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

plot(t,neuronVoltage)
title('Neuron With Injected Current (w/out Leak Current) ')

%% 3) Leak Current to be biologically realistic 
clear all 
dt=.01;  %increment
t=0:dt:50;  %Time in seconds- 10 secs
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV
neuronVoltage=zeros(size(t));
injectedCurrent=15*dt; %The neuron's voltage will increase by 15mV/sec
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)  %for every time value
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10;
    if i<500%make the the neuron lose the injected current
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %increases mV from resting by injected current
    else 
    neuronVoltage(i)=neuronVoltage(i-1)-leakCurrent; %increases mV from resting by injected current
    end
    if neuronVoltage(i)>threshold && neuronVoltage(i)<spikeAmp  %If reached threshold, make neuron spike
        neuronVoltage(i)=spikeAmp; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >spikeAmp  %if over the spikeAmp, go back to resting without leak current
        neuronVoltage(i)= restingV;
    end
end
figure(2)

plot(t,neuronVoltage)
title('Neuron With Injected Current (with Leak Current) ')
%% 4)Add noise
%% with injected current
clear all 
dt=.01;  %increment
t=0:dt:50;  %Time in seconds- 10 secs
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV
neuronVoltage=zeros(size(t));
injectedCurrent=15*dt; %The neuron's voltage will increase by 15mV/sec
neuronVoltage(1)=restingV; %setting the first value to resting potential
A=100;% factor is equal to 100
for i=2:length(t)  %for every time value
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10;
    if i<500%make the the neuron lose the injected current
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent+randn*A*dt; %increases mV from resting by injected current and increase a random voltage due to the noise
    else 
    neuronVoltage(i)=neuronVoltage(i-1)-leakCurrent; %increases mV from resting by injected current
    end
    if neuronVoltage(i)>threshold && neuronVoltage(i)<spikeAmp  %If reached threshold, make neuron spike
        neuronVoltage(i)=spikeAmp; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >spikeAmp  %if over the spikeAmp, go back to resting without leak current
        neuronVoltage(i)= restingV;
    end
end
figure(3)

plot(t,neuronVoltage)
title('Neuron With Injected Current (with Leak Current and noise with injected current) ')
%% without any injected current A=100
clear all 
dt=.01;  %increment
t=0:dt:50;  %Time in seconds- 10 secs
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV
neuronVoltage=zeros(size(t));

neuronVoltage(1)=restingV; %setting the first value to resting potential
A=100;%factor is equal to 100
for i=2:length(t)  %for every time value
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10;
    
    neuronVoltage(i)=neuronVoltage(i-1)-leakCurrent+randn*A*dt; %increases mV from resting by injected current and add a random voltage due to the noise in every steps
   
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<spikeAmp  %If reached threshold, make neuron spike
        neuronVoltage(i)=spikeAmp; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >spikeAmp  %if over the spikeAmp, go back to resting without leak current
        neuronVoltage(i)= restingV;
    end
end
figure(3)
plot(t,neuronVoltage)
title('Neuron Without Injected Current (with Leak Current and noise without injected current A=100)')
%It can generate spikes without the help of injected current when A =100
%% without any injected current A=10
clear all 
dt=.01;  %increment
t=0:dt:50;  %Time in seconds- 10 secs
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV
neuronVoltage=zeros(size(t));

neuronVoltage(1)=restingV; %setting the first value to resting potential
A=10;%factor is equal to 10
for i=2:length(t)  %for every time value
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10;
    
    neuronVoltage(i)=neuronVoltage(i-1)-leakCurrent+randn*A*dt; %increases mV from resting by injected current and increase a random voltage due to the noise
   
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<spikeAmp  %If reached threshold, make neuron spike
        neuronVoltage(i)=spikeAmp; %the spike (the overshoot) 
    end    
    %Falling phase
    if neuronVoltage(i) >spikeAmp  %if over the spikeAmp, go back to resting without leak current
        neuronVoltage(i)= restingV;
    end
end
figure(4)
plot(t,neuronVoltage)
title('Neuron Without Injected Current (with Leak Current and noise without injected current A=10)')
% It can't generate any spike with the help of injected current, when A=10


 %% Two IF Neurons 

% 1) Excitatory Input on a second neuron 

clear all 
dt=.01;

t=0:dt:20;%runs for 50 seconds 

injectedCurrent = 15*dt;  %Injected Current is 15 mV 

restingV=-70; %-70 mV is resting potential 

threshold=-55; % Threshold- Where action potential stimulted

spikeAmp=50; %spikes to 50 mV

 

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs

neuronVoltage = zeros(size(t)); %Increases the size of the first neuron to 50 secs. 

neuronVoltage(1)=restingV;

neuronVoltage2(1)=restingV;

for i=2:length(t)  %for every time value

   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current value based on euler 

 

    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %First neuron still gets injected current

    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike

        neuronVoltage(i)=50; %the spike (the overshoot) 

        neuronVoltage2(i) = neuronVoltage2(i-1) + 5; %If first spike, mV of second Neuron increases by 5

    else

       neuronVoltage2(i) = neuronVoltage2(i-1); % if the 1st Neuron doesn't fire, the second neuron simply inherits its charge from before

        if neuronVoltage(i) >40  %if over the spikeAmp, leak current decay back

        neuronVoltage(i)= restingV;

        end

    end

    

     if neuronVoltage2(i)>threshold && neuronVoltage2(i)<40

        neuronVoltage2(i)=50;

    elseif neuronVoltage2(i)>40

        neuronVoltage2(i)=restingV;

    end

 

end
figure(5) 
clf
plot(t,neuronVoltage)
hold on
plot(t,neuronVoltage2)
legend('1st' , '2nd') 
title('Excitatory input on a second neuron')





 



