%% Section1: Integrate and Fire Neuron

% 1)Creating an Integrate and Fire Neuron **********


dt=.01;  %interval of time, increment by .01 
t=0:dt:10;  %Time in seconds- 10 secs

neuronVoltage=zeros(size(t));  %Creates vector that stores the mV of time
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulated
spikeAmp=50 %spikes to 50 mV 
for i=2:length(t)  %Goes through the length of time, starts at 2 so can do (i-1)
     if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %if reached threshold and less than 50
         neuronVoltage(i)=spikeAmp;  %go to spike
     end
     if neuronVoltage(i)>50  %if greater than 50, meaning already spiked, go to resting 
         neuronVoltage(i)=resting; %go to resting
     end
end
% 2) Adding a Stimulus **********
injectedCurrent=15*dt; %The neuron's voltage will increase by 15mV/sec; times dt to add the right amount to each interval
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)  %for every time value
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent; %increases mV frome last level by injected current  
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<50  %If reached threshold and under 50 make neuron spike 
        neuronVoltage(i)=50; %the spike (the overshoot) 
    end    
    %Goes back to resting 
    if neuronVoltage(i) >50  %if over the spikeAmp, meaning already spiked, go back to resting without leak current
        neuronVoltage(i)= restingV; % returns
    end
end
figure(1)  %plots in figure 1 
plot(t,neuronVoltage)
title('1.2: Neuron With Injected Current (15mV/sec)')
xlabel('Time') 
ylabel('mV')

% 3) Leak Current to be biologically realistic **********
% Sherry
t=0:dt:50;  %Time in seconds- runs for 50 secs
neuronVoltage=zeros(size(t)) %resetting the voltage vector to all 0
neuronVoltage(1)=restingV; %setting the first value to resting potential
for i=2:length(t)  %for every time value, starts at 2 so can do (i-1) 
    leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current value based on euler equation
    if i<2500  %Used to stop current at halfWay (bc in total, 5,000 indecis) 
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %increases mV from last value by injected current *takes into account of the leak 
    else  %once current stops 
    neuronVoltage(i)=neuronVoltage(i-1)-leakCurrent; %No injected current anymore, only leak current: should gradually go back to normal
    end
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike 
        %less than 40 takes into consideration of leak current
        neuronVoltage(i)=50; %the spike (the overshoot) 
    %Falling back to rest
    elseif neuronVoltage(i) >40  % if greater than 40 (for the leak) current goes back to resting
        neuronVoltage(i)= restingV; %resets to resting
    end
end
figure(2) %plots in figure 2 
clf
plot(t,neuronVoltage)
title('Neuron With Injected Current and Leak Current (Stops in the middle)')
xlabel('Time') 
ylabel('mV')

% 4)Add noise **********
%   - With injected current
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
title('Neuron With Injected Current (with Leak Current and Noise with injected current) ')
xlabel('Time') 
ylabel('mV')

% Without any injected current A=100
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
figure(4)
plot(t,neuronVoltage)
title('Neuron Without Injected Current (with Leak Current and Noise without injected current A=100)')
xlabel('Time') 
ylabel('mV')

%***It can generate spikes without the help of injected current when A=100

%Without any injected current A=10
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
figure(5)
plot(t,neuronVoltage)
title('Neuron Without Injected Current (with Leak Current and noise without injected current A=10)')
xlabel('Time') 
ylabel('mV')

% ***It can't generate any spike with the help of injected current, when A=10

%% Two IF Neurons 

% 1) Excitatory Input on a second neuron **********
% Sherry Shi
clear all

dt=.01; %time interval increments by .01 
t=0:dt:50; %runs for 50 seconds

injectedCurrent = 15*dt;  %Injected Current is 15 mV * dt 
restingV=-70; %-70 mV is resting potential
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs
neuronVoltage = zeros(size(t)); %Stores voltage of the first neuron for 50 secs
neuronVoltage(1)=restingV;  %Neuron 1 starts at resting potential 
neuronVoltage2(1)=restingV;  %Neuron 2 starts at resting potential 

for i=2:length(t)  %for every time value, from 2 for (i-1) 
    leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current for first neuron based on euler
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %First neuron still gets injected current and leaks current
    leakCurrent=((neuronVoltage2(i-1)-restingV)*dt)/10; %defining the leak current for second neuronvalue based on euler
    neuronVoltage2(i)=neuronVoltage2(i-1)-leakCurrent; %Second Neuron no injected current, only leak current 
    
    %For the first neuron spike
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, less than 40 (for leak), make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot)
        neuronVoltage2(i) = neuronVoltage2(i-1) + 5; %If first spike, mV of second Neuron increases by 5
    else
        neuronVoltage2(i) = neuronVoltage2(i-1); % If the 1st Neuron doesn't fire, the second neuron simply inherits its charge from before
        if neuronVoltage(i) > 40  %if over the spikeAmp (40 for leak)goes back to resting 
            neuronVoltage(i)= restingV; %returns to resting
        end
    end
    %For the second neuron spike
    if neuronVoltage2(i)>threshold && neuronVoltage2(i)<40 %If reached threshold, less than 40 (for leak), make neuron spike
        neuronVoltage2(i)=50; %spikes 
    elseif neuronVoltage2(i)>40  %if over the spikeAmp (40 for leak)goes back to resting 
        neuronVoltage2(i)=restingV;  %Goes back to resting 
    end
end
figure(6) %Plots in figure 6 
clf
plot(t,neuronVoltage) %Plots the first neuron
hold on
plot(t,neuronVoltage2) %Plots the second neuron 
legend('1st' , '2nd') 
title('Excitatory input on a second neuron') 
xlabel('Time') 
ylabel('mV')

% 2) Adjusting firing rate **********
% Mostly copied from 2.1. Partially written by Li Zehua.

% The ratio of spikes in neuron 1 to neuron 2 equals merely 4.
% It does change based on how much neuron 1 fires, but the change is pretty
% small.

clear all

dt=.01;
t=0:dt:49997; %runs for 49997 seconds

injectedCurrent = 15*dt;  %Injected Current is 15 mV 
restingV=-70; %-70 mV is resting potential
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs
neuronVoltage = zeros(size(t)); %Increases the size of the first neuron to 50 secs. 

neuronVoltage(1)=restingV;
neuronVoltage2(1)=restingV;

count = zeros(1, 2); % Initialize the vector to store how many time neurons spike.

for i=2:length(t)  %for every time value
    leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current value based on euler
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %First neuron still gets injected current
    leakCurrent=((neuronVoltage2(i-1)-restingV)*dt)/10; %defining the leak current value based on euler
    neuronVoltage2(i)=neuronVoltage2(i-1)-leakCurrent;
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot)
        count(1) = count(1) + 1;
        neuronVoltage2(i) = neuronVoltage2(i-1) + 5; %If first spike, mV of second Neuron increases by 5
    else
        neuronVoltage2(i) = neuronVoltage2(i-1); % if the 1st Neuron doesn't fire, the second neuron simply inherits its charge from before
        if neuronVoltage(i) > 40  %if over the spikeAmp, leak current decay back
            neuronVoltage(i)= restingV;
        end
    end
    if neuronVoltage2(i)>threshold && neuronVoltage2(i)<40
        neuronVoltage2(i)=50;
        count(2) = count(2) + 1;
    elseif neuronVoltage2(i)>40
        neuronVoltage2(i)=restingV;
    end
end

ratio = count(1) / count(2); % The ratio of spikes in neuron 1 to neuron 2.

% 3) Increase the rate of fire **********
clear all 
dt=.01;
t=0:dt:50;%runs for 50 seconds 
injectedCurrent = 20*dt;  %change the Injected Current to 20 mV per second
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs
neuronVoltage = zeros(size(t)); %Increases the size of the first neuron to 50 secs. 

neuronVoltage(1)=restingV;
neuronVoltage2(1)=restingV;

for i=2:length(t)  %for every time value
    leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current value based on euler method
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %First neuron still gets injected current
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot)
        neuronVoltage2(i) = neuronVoltage2(i-1)+2; %If first spike, mV of second Neuron increases by 2
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
figure(7) 
clf
plot(t,neuronVoltage)
hold on
plot(t,neuronVoltage2)
legend('1st' , '2nd') 
title('2.3 Increase the Rate of Fire')
xlabel('Time') 
ylabel('mV')

%% Extra Credit: Facilitation and Depression
 
% 1) Modeling Facilitation **********
clear all

dt=.01;
t=0:dt:50; %runs for 50 seconds

injectedCurrent = 20*dt;  %Injected Current is 20 mV 
restingV=-70; %-70 mV is resting potential
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50; %spikes to 50 mV
calcium=0; % To store the amount of calcium, initialize the variable calcium to 0.

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs
neuronVoltage = zeros(size(t)); %Increases the size of the first neuron to 50 secs. 

neuronVoltage(1)=restingV;
neuronVoltage2(1)=restingV;

for i=2:length(t)  %for every time value
    leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current value based on euler
    neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %First neuron still gets injected current
    leakCurrent=((neuronVoltage2(i-1)-restingV)*dt)/10; %defining the leak current value based on euler
    neuronVoltage2(i)=neuronVoltage2(i-1)-leakCurrent;
    
    % Calcium looply decline.
    deltaCalcium = - calcium * dt / 10; % Calculate the delta of calcium.
    if calcium + deltaCalcium >= 0 % If still bigger than or equal to 0, calcium plus delta. 
        calcium = calcium + deltaCalcium;
    else % If not, calcium equals 0.
        calcium = 0;
    end
    
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike
        neuronVoltage(i)=50; %the spike (the overshoot)
        calcium = calcium + 1; % If neuron 1 spikes, add 1 to calcium.
        neuronVoltage2(i) = neuronVoltage2(i-1) + 2 * calcium; %If first spike, mV of second Neuron increases by 5
    else
        neuronVoltage2(i) = neuronVoltage2(i-1); % if the 1st Neuron doesn't fire, the second neuron simply inherits its charge from before
        if neuronVoltage(i) > 40  %if over the spikeAmp, leak current decay back
            neuronVoltage(i)= restingV;
        end
    end
    if neuronVoltage2(i)>threshold && neuronVoltage2(i)<40
        neuronVoltage2(i)=50;
    elseif neuronVoltage2(i)>40
        neuronVoltage2(i)=restingV;
    end
end
figure(8) 
clf
plot(t,neuronVoltage)
hold on
plot(t,neuronVoltage2)
legend('1st' , '2nd') 
title('Excitatory input on a second neuron')
xlabel('Time') 
ylabel('mV')

% 2) Modeling Depression **********
% Sherry Shi 
clear all 
dt=.01  %Time interval increment 
t=0:dt:50%runs for 50 seconds 
injectedCurrent = 15*dt  %Injected Current is 15 mV 
restingV=-70; %-70 mV is resting potential 
threshold=-55; % Threshold- Where action potential stimulted
spikeAmp=50 %spikes to 50 mV

neuronVoltage2= zeros(size(t)); % Stores voltage of a second neuron for 50 secs
neuronVoltage = zeros(size(t)); %Stores voltage of the first neuron for 50 secs. 
neuronVoltage(1)=restingV;  %Sets first value of first neuron to resting potential 
neuronVoltage2(1)=restingV; %Sets first value of second neuron to resting potential
strength=10  %Completely arbitrary value, picked an initial Strength to increase by
for i=2:length(t)  %for every time value, starts at 2 to do (i-1)
   leakCurrent=((neuronVoltage(i-1)-restingV)*dt)/10; %defining the leak current of 1st value based on euler equation
   neuronVoltage(i)=neuronVoltage(i-1)+injectedCurrent-leakCurrent; %First neuron still gets injected current
   leakCurrent2=((neuronVoltage2(i-1)-restingV)*dt)/10; %defining the leak current of 2nd value based on euler equation
   neuronVoltage2(i)=neuronVoltage2(i-1)-leakCurrent; %Second neuron no injected current, depends on the first, but has leak current 
    if neuronVoltage(i)>threshold && neuronVoltage(i)<40  %If reached threshold, make neuron spike, 40 for leak
        neuronVoltage(i)=50; %the spike (the overshoot) 
        strength=strength*.9  %Strength of impact on second neuron decreased by 10% 
        neuronVoltage2(i) = neuronVoltage2(i-1) + (strength) ; %If first spike, mV of second Neuron increases whatever strength is
        %over time, strength should decrease
        %Vesicle variable isn't included bc assuming each spikes is -10%
        %vesicles, it doesn't have an effect on the code
    else
       neuronVoltage2(i) = neuronVoltage2(i-1); % if the 1st Neuron doesn't fire, the second neuron simply inherits its charge from before
        if neuronVoltage(i) >40  %if over the spikeAmp, 40 for leak, 
        neuronVoltage(i)= restingV; %go back to resting 
        end 
    end
    %For the spikes of the 2nd neuron 
     if neuronVoltage2(i)>threshold && neuronVoltage2(i)<40  %If reached threshold, make neuron spike, 40 for leak
        neuronVoltage2(i)=50; %spikes
    elseif neuronVoltage2(i)>40 %If over spikeAmp, 40 for leak, go back to resting 
        neuronVoltage2(i)=restingV; %returns to resting 
    end

end
figure(9)  %plots on figure 9 
clf
plot(t,neuronVoltage)
hold on %first and second neuron plots on same  graph 
plot(t,neuronVoltage2)
legend('1st' , '2nd') 
title('Extra Credit 2: Depression Synapse')
xlabel('Time') 
ylabel('mV')






