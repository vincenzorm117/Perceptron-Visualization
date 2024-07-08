//
//  main.cpp
//  binary_play
//
//  Created by Vincenzo on 2/12/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <random>


bool compare (int a, int b) { return a < b; }

using namespace std;


class perceptron {
    vector<double> weights;
    const double learningRate;
    double w0;
    double x0;
    
public:
    perceptron(vector<double>,double,double);
    void learn(vector<double>,int);
    void display(bool);
};

perceptron::perceptron(vector<double> weights, double lR = 0.1, double w0 = 1):
learningRate(lR), w0(w0), weights(weights){
    x0 = 1;
}

void perceptron::display(bool fire){
//    if (fire) {
//        cout << "Fire       | ";
//    } else {
//        cout << "Don't Fire | ";
//    }
    
    cout << w0 << " ";
//    for (int i = 0; i < weights.size(); i++) {
//        cout << weights[i] << " ";
//    }
    cout << "+ " << weights[0] << "x + " << weights[1] << "y = 0";
    cout << endl;
}


void perceptron::learn(vector<double> inputs, int label){

    if(inputs.size() == weights.size()){
        double buff = w0 * x0;
        
        for (int i = 0; i < weights.size(); i++)
            buff += weights[i] * inputs[i];
        
        int output = (0 < buff)? 1 : 0;
        
        
        if(output != label){
            cout << "adjust" << endl;
            w0 += learningRate * (label - output);
            
            for (int i = 0; i < weights.size(); i++)
                weights[i] += learningRate * ((double)label - output) * inputs[i];
        }
        
        
       
    }
}


int main(int argc, const char * argv[]) {
    
    normal_distribution<double> dist(0.0, 500.0);
    default_random_engine gen;
    gen.seed((unsigned int)time(0));
    
    vector<double> weigths;
    weigths.push_back(dist(gen));
    weigths.push_back(dist(gen));
    
    ifstream in;
    perceptron p(weigths, 20.0, dist(gen));
    
    for (int k = 0; k < 100000; k++) {
        
        in.open("visual.txt");
        int count = 0, vecSize = 0;
        double read;
        in >> count;
        in >> vecSize;
        vector<double> inputs;
        
        while (count-- > 0) {
            
            for (int i = 0; i < vecSize; i++) {
                in >> read;
                inputs.push_back(read);
            }
            in >> read;
            
            p.learn(inputs, read);
            
            
            inputs.clear();
        }
    }
    
    p.display(true);
    
    return 0;
}











