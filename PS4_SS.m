%% Section1: Integrate and Fire Neuron

% 1)Creating an Integrate and Fire Neuron 
dt=.01;  %increment
t=0:dt:10;  %Time in seconds- 10 secs

neuronVoltage=zeros(size(t));  %Size of voltage vector (recorded in mV)= time
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50 %spikes to 50 mV
for i=2:length(t)  %Goes through the length of time
     if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %if reached threshold and less than 50
         neuronVoltage(i)=spikeAmp;  %go to spike
     end
     if neuronVoltage(i)>50  %if greater than 50, go to resting 
         neuronVoltage(i)=restingV;
     end
end
% 2) Adding a Stimulus 
injectedCurrent=15*dt; %The neuron's voltage will increase by 15mV/sec
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)  %for every time value
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent; %increases mV from resting by injected current
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >50  %if over the spikeAmp, go back to resting without leak current
        neuronVoltage(i)= restingV;
    end
end
figure(1)
clf
plot(t,neuronVoltage)
title('Neuron With Injected Current (w/out Leak Current) ')

% 3) Leak Current to be biologically realistic 

t=0:dt:50;  %Time in seconds- 10 secs
neuronVoltage=zeros(size(t))
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)  %for every time value
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10;
    if i<500
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %increases mV from resting by injected current
    else 
    neuronVoltage(i)=neuronVoltage(i-1)-leakCurrent; %increases mV from resting by injected current
    end
    if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >50  %if over the spikeAmp, go back to resting without leak current
        neuronVoltage(i)= restingV;
    end
end
figure(1)
clf
plot(t,neuronVoltage)
title('Neuron With Injected Current (w/out Leak Current) ')

%% Two IF Neurons 
% 1) Excitatory Input on a second neuron 
clear all 
dt=.01
t=0:dt:50  %runs for 50 seconds 
injectedCurrent = 15  %Injected Current is 15 mV 
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50 %spikes to 50 mV

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs
neuronVoltage = zeros(size(t)); %Increases the size of the first neuron to 50 secs. 
neuronVoltage(1)=restingV;
neuronVoltage2(1)=restingV;

for i=2:length(t)  %for every time value
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current value based on euler 
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %increases mV from resting by injected current minus leak 
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike 
        %less than 40 takes into consideration of leak current
        neuronVoltage(i)=50; %the spike (the overshoot) 
        neuronVoltage2(i)=neuronVoltage2(i-1)+1;
   
    %Falling back to rest
    elseif neuronVoltage(i) >40  % if greater than 40 (for the leak) current goes back to resting
        neuronVoltage(i)= restingV; %resets to resting
    end
    
    if neuronVoltage2(i)>threshold && neuronVoltage2(i)<50 %If second neuron hits threshold, fire
        neuronVoltage2(i)=50; 
    elseif neuronVoltage2(i) >= 50 %if over the spikeAmp, leak current decay back 
     neuronVoltage2(i)=restingV; 
  end
    
end

figure(3) 
clf
plot(t,neuronVoltage)
hold on
plot(t,neuronVoltage2)
legend('1st' , '2nd') 