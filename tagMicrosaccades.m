% This function searches for microsaccades according to the specified
% parameters.
% 
% Properties: 'minvel'   : Minimum velocity of the saccade 
%                          (in arcmin/s, default: 180arcmin/s)
%             'minmsa'   : Minimum microsaccade amplitude 
%                          (default: 3arcmin)
%             'maxmsa'   : Maximum microsaccade amplitude 
%                          (default: 30arcmin)
%             'minterval': Minimum distance between two separate 
%                          events (in ms, default: 15ms) 
%             'mduration': Minimum length of the saccade
%                          (in ms, default: 15ms) 
%             'shift'    : Shift the beginning of the event 
%                          (in samples: >0 Delay, <0 Anticipate, 
%                          default: 0ms)
%             'increment': Increase the length of the events 
%                          (in ms, default: 5ms)
%
% Trial     : Updated trial structure 
%
function Trial = tagMicrosaccades(x,y,srate, varargin)

  % Initialize all variables
  MinVelocity = 180;
  MinMSAmplitude = 3;
  MaxMSAmplitude = 30;
  MinInterval = 15;
  MinDuration = 15;
  Shift = 0;
  IncDuration = 5;

  % Interpret the user parameters
  k = 1;
  while k <= length(varargin) && ischar(varargin{k})
    switch (lower(varargin{k}))
      case 'minvel'
        MinVelocity = varargin{k + 1};
        k = k + 1;
      case 'minmsa'
        MinMSAmplitude = varargin{k + 1};
        k = k + 1;
      case 'maxmsa'
        MaxMSAmplitude = varargin{k + 1};
        k = k + 1;
      case 'minterval'
        MinInterval = varargin{k + 1};
        k = k + 1;
      case 'mduration'
        MinDuration = varargin{k + 1};
        k = k + 1;
      case 'shift'
        Shift = varargin{k + 1};
        k = k + 1;
      case 'increment'
        IncDuration = varargin{k + 1};
        k = k + 1;
      otherwise
        p_ematError(3, 'findMicrosaccades');
    end
    k = k + 1;
  end

   dist = sqrt(dx.^2+dy.^2);
   vel = dist./dt;
   % Find all movements with speed greater than 
  % the minimum velocity 
  Events = findEvents(vel, ...
    'minvel', MinVelocity, ...
    'minterval', MinInterval, ...
    'mduration', MinDuration, ...
    'shift', Shift, ...
    'increment', IncDuration, ...
    'sRate', srate);                %%% YB@2018.10.27.

  % Filter all movements within a blink event
  Events = filterIntersected(Events, Trial.blinks);

  % Filter all movements within the track trace
  Events = filterIntersected(Events, Trial.notracks);

  % Filter all movements within the invalid list
  Events = filterIntersected(Events, Trial.invalid);

  % Filter all movements that do not fall within 
  % the stimulus timeframe
  Events = filterNotIncluded(Events, Trial.analysis);

  % Calculate the amplitudes/angles of the movements 
% % %   counter = 1;
% % %   startTemp = 0;
% % %   if isempty(Events.start)
% % %       for i = 1:Trial.samples-7
% % %           if diff([Trial.x.position(i+7), Trial.x.position(i)]) > 15
% % %               if i == 1 || 2 || 3 || 4 
% % %                   startTemp(counter) = 1;%Trial.x.position(i);
% % %               else
% % %                   startTemp(counter) = abs(i-5);%Trial.x.position(i);
% % %               end
% % %               counter = counter + 1;
% % %           end
% % %       end
% % %   end
% % %   Events.start = unique(ceil(startTemp/15)*15);
% % %   Events.duration = ones(1,length(Events.start))*25;
  Events = updateAmplitudeAngle(Trial, Events);

  % Filter all movements with an amplitude according to 
  % minimum and maximum amplitude
  Events = filterBy('amplitude', Events, MinMSAmplitude, MaxMSAmplitude);

  % Save the filtered events into the trial 
  if ~isempty(Events)
    Trial.microsaccades = Events;

    % Update the list of events fixations
    Trial.fixations = joinEvents(Events, Trial.drifts);
    Trial.fixations = updateAmplitudeAngle(Trial, Trial.fixations);
  end
end