
%% Section1: Integrate and Fire Neuron

%Creating an Integrate and Fire Neuron 
dt=.01;  %increment
t=0:dt:10;  %Time in seconds

neuronVoltage=zeros(size(t));  %Size of voltage vector (recorded in mV)= time
restingV=-70; %-70 mV is resting potential 
threshold=-55; %-rrmV Where action potential stimulted

%start by injecting current directly into the neuron and making its voltage
%slowly go up 

injectedCurrent=5*dt; %The neuron's voltage will increase by 5mV/sec
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent;
    %over the course of 1 second (100 bc .01 dt)neurons voltage increas by
    %5mV (which was divided /10O)
    
    %The other part is we want this neuron to fire
    %Threshold SPIKE
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot) 
        disp('spike')
    end
    %Starts at resting membrane potential, slow increases until hit
    %threshold, and then spike
    
    %Falling phase
    if neuronVoltage(i) >50
        neuronVoltage(i)= restingV;
    end
end
figure(1)
clf
plot(t,neuronVoltage)
title('IF neuron without leak current ')

