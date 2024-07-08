//
//  main.cpp
//  NeuralNetC++
//
//  Created by Vincenzo on 2/18/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//

#include <iostream>
#include <cmath>
#include <ctime>
#include <cstdlib>


using namespace std;

double vrand(){
    return (double(rand() / double(RAND_MAX)) - 0.5);
}

double errThisPat = 0.0;

double inputs[4][4];


    double hidden[4];
    double output;

    double wih[3][4];
    double who[4];
    
    double lr_ih = 0.7;
    double lr_ho = 0.07;
    
    
    void init(){
        
        
        for (int i = 0; i < 4; i++) {
            
            hidden[i] = 0.0;
            who[i] = vrand() / 2.0;
            
            for (int j = 0; j < 3; j++) {
                wih[j][i] = vrand() / 5.0;
                cout << "Weight = " << wih[j][i] << endl;
            }
        }
        
        output = 0.0;
    }


void calcNet(int patNum){

    for(int i = 0; i < 4; i++){
        hidden[i] = 0.0;
        
        for(int j = 0; j < 3; j++){
            hidden[i] = hidden[i] + (inputs[patNum][j] * wih[j][i]);
        }
        
        hidden[i] = tanh(hidden[i]);
    }
    
    output = 0.0;
    
    for(int i = 0; i < 4; i++){
        output = output + hidden[i] * who[i];
    }
    
    cout << output << endl;
    //Calculate the error: "Expected" - "Actual"
    errThisPat = output - inputs[patNum][3];
}


void WeightChangesHO(){
    //Adjust the Hidden to Output weights.
    
    for(int k = 0; k < 4; k++){
        double weightChange = lr_ho * errThisPat * hidden[k];
        who[k] = who[k] - weightChange;
        
        // Regularization of the output weights.
        if (who[k] < -5){
            who[k] = -5;
        }else if (who[k] > 5){
            who[k] = 5;
        }
    }
}

void WeightChangesIH(int patNum){
    // Adjust the Input to Hidden weights.
    
    for(int i = 0; i < 4; i++){
        
        for(int k = 0; k < 3; k++){
            
            double x = 1 - (hidden[i] * hidden[i]);
            x = x * who[i] * errThisPat * lr_ih;
            x = x * inputs[patNum][k];
            double weightChange = x;
            wih[k][i] = wih[k][i] - weightChange;
        }
    }
}


    double feedForward(int patNum){
        
        
        for(int i = 0; i < 4; i++){
            hidden[i] = 0.0;
            for(int j = 0; j < 3; j++){
                hidden[i] = hidden[i] +  (wih[j][i] * inputs[patNum][j]);
            }
            
            hidden[i] = tanh(hidden[i]);
        }
        
        output = 0.0;
        for (int i = 0; i < 4; i++) {
            output = output + hidden[i] * who[i];
        }
        
//        cout << output << endl;
        
        
        errThisPat = output - inputs[patNum][3];
        
        return output;
    }
    
    
    double backProp(double label, int patNum){
        
        double error = output - label;
        
        cout << label << " - " << output << " = " << error << endl;
        
        for(int i = 0; i < 4; i++){
            
            who[i] = who[i] - lr_ho * error * hidden[i];
            
            if(who[i] > 5.0) {
                who[i] = 5.0;
            } else if(who[i] < -5.0){
                who[i] = -5.0;
            }
        }
        
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                double buff = 1.0 - (hidden[i]*hidden[i]);
                buff = buff * who[i] * error * lr_ih;
                buff = buff * inputs[patNum][j];
                wih[j][i] = wih[j][i] - buff;
            }
        }
        return error;
    }
    
    




int main(int argc, const char * argv[]) {

    srand((unsigned)time(0));

    
    inputs[0][0] = -1;
    inputs[0][1] = -1;
    inputs[0][2] =  1;
    inputs[0][3] = -1;
    
    inputs[1][0] = -1;
    inputs[1][1] =  1;
    inputs[1][2] =  1;
    inputs[1][3] =  1;
    
    inputs[2][0] =  1;
    inputs[2][1] = -1;
    inputs[2][2] =  1;
    inputs[2][3] =  1;
    
    inputs[3][0] =  1;
    inputs[3][1] =  1;
    inputs[3][2] =  1;
    inputs[3][3] =  -1;

    
    init();
    
    int iterations = 200;
    
    for(int i = 0; i < iterations; i++){
        
        for (int j = 0; j < 4; j++) {
            feedForward(j);
            backProp(inputs[j][3],j);
//            calcNet(j);
//            backProp(inputs[j][3],j);
//            WeightChangesHO();
//            WeightChangesIH(j);
        }
    }
    
    
    for (int j = 0; j < 4; j++) {
        calcNet(j);
        cout << inputs[j][3] << " : " << output << endl;
    }
    
    
}
































