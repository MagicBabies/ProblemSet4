
%% Section1: Integrate and Fire Neuron

% 1)Creating an Integrate and Fire Neuron 
dt=.01;  %increment
t=0:dt:10;  %Time in seconds- 10 secs

neuronVoltage=zeros(size(t));  %Size of voltage vector (recorded in mV)= time
restingV=-70; %-70 mV is resting potential 
threshold=-55; %-rrmV Where action potential stimulted
spikeAmp=50 %spikes to 50 mV
for i=2:length(t) 
     if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %if reached threshold and less than 50
         neuronVoltage(i)=spikeAmp;  %go to spike
     end
     if neuronVoltage(i)>50  %if greater than 50, go to resting 
         neuronVoltage(i)=restingV;
     end
end
% 2) Adding a Stimulus 
injectedCurrent=15*dt; %The neuron's voltage will increase by 5mV/sec
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent; %increases mV from resting by injected current
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >50
        neuronVoltage(i)= restingV;
    end
end
figure(1)
clf
plot(t,neuronVoltage)
title('Neuron without leak current ')

