%%% Script for Analyzing Huxlin Data and Creating Manuscript Figures
clear all
close all
temp = load('dataTableStroke.mat');

temp = load('tableInfoStoke.mat');
taskPPTrials = temp.taskPPTrials.tableInfo;

tableSubjectInfo = struct2table(temp.dataTable); %% Also Table 1
%% Figure 2A - Heatmaps for Fixation
axisVal = 25;
figure('Position',[2000 -10 1200 3000]);
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 1))' %Patients
    subplot(4,4,counter)
    if counter == 1
    heatMapIm = generateHeatMapSimple( ...
        tableSubjectInfo.fixX{ii}, ...
        tableSubjectInfo.fixY{ii}, ...
        'Bins', 30,...
        'StimulusSize', 0,...
        'AxisValue', axisVal,...
        'Uncrowded', 4,...
        'Borders', 1);
    xlabel('arcminutes');
    ylabel('arcminutes');
    else
        heatMapIm = generateHeatMapSimple( ...
        tableSubjectInfo.fixX{ii}, ...
        tableSubjectInfo.fixY{ii}, ...
        'Bins', 30,...
        'StimulusSize', 0,...
        'AxisValue', axisVal,...
        'Uncrowded', 4,...
        'Borders', 0);
    end
    hold on
    line([0 0],[-axisVal axisVal],'LineStyle','--','Color','k','LineWidth',1);
    line([-axisVal axisVal],[0 0],'LineStyle','--','Color','k','LineWidth',1);
    axis square
    title(ii);
    counter = counter + 1;
end

figure('Position',[2000 -10 1200 3000]);
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 0))' %Controls
    subplot(4,4,counter)
    if ii == 15
        [x,id] = unique(tableSubjectInfo.fixX{ii});
        y = tableSubjectInfo.fixY{ii}(id);
        heatMapIm2{counter} = generateHeatMapSimple( ...
        x, ...
        y, ...
        'Bins', 30,...
        'StimulusSize', 0,...
        'AxisValue', axisVal,...
        'Uncrowded', 4,...
        'Borders', 0);
    else
    heatMapIm2{counter} = generateHeatMapSimple( ...
        tableSubjectInfo.fixX{ii}, ...
        tableSubjectInfo.fixY{ii}, ...
        'Bins', 30,...
        'StimulusSize', 0,...
        'AxisValue', axisVal,...
        'Uncrowded', 4,...
        'Borders', 0);
    end
    hold on
    line([0 0],[-axisVal axisVal],'LineStyle','--','Color','k','LineWidth',1);
    line([-axisVal axisVal],[0 0],'LineStyle','--','Color','k','LineWidth',1);
    axis square
    title(ii);
    
    counter = counter + 1;
end

% %% Get some windows of fixations for 3 subjects
% for ii = [4 6 8]
%     x = tableSubjectInfo.fixX{ii};
%     y = tableSubjectInfo.fixY{ii};
%
%     figure;
%     plot(1:length(x),x);
%     title(ii)
% end
% goodSamples8 = [213351 214863 ...
%     221757 223634 ...
%     224879 225828 ...
%     228974 230686];
%
% goodSamples6 = [205766 208352 ...
% 210967 213628 ...
% 233359 234448 ...
% 257190 257749];
%
% goodSamples4 = [67840 69146 ...
%    71317  72459 ...
%    74855  76054 ...
%    84249  86534 ];
%
% figure;
% counter = 1;
% for ii = (find(tableSubjectInfo.Stroke == 1))'
%   subplot(4,4,counter)
%     temp = tableSubjectInfo.vfMap{ii};
%     temp(isnan(temp)) = -20;
%
%     rotateAngle = 0;
%     J = imrotate((temp),rotateAngle);
%     J(find(J == -20)) = max(max(J));
%
%     imagesc(J);
%     axis square;
%     set(gca,'XTick',[],'YTick',[])
%
%     colormap((gray))
%     counter = counter + 1;
% end
%
% plotexamplemap(8,tableSubjectInfo, goodSamples8);
% plotexamplemap(6,tableSubjectInfo, goodSamples6);
% plotexamplemap(4,tableSubjectInfo, goodSamples4);


%% Figure 2B - BCEA for Fixation

figure;
boxplot(tableSubjectInfo.bceaFix,...
    tableSubjectInfo.Stroke','PlotStyle','compact',...
    'Labels',{'Control','Patient'});
% plot(rand(5,1))
% sigline([2,4])

set(gca, 'YScale', 'log')
ylim([.05 10])
yticks([.3 1 2 10])
xticks([1 2])
% xticklabels({''});
% xticklabels({'Control','Patient'});
[h,p,~,sts] = ttest2(tableSubjectInfo.bceaFix(tableSubjectInfo.Stroke == 1),...
    tableSubjectInfo.bceaFix(tableSubjectInfo.Stroke == 0));
title(sprintf('n.s., p = %.2f',p));
ylabel('BCEA (deg^2)')

%% Get some names lined up with subject names
subjectsAll = {'HUX1','HUX3','HUX5','HUX6','HUX7','HUX8','HUX9','HUX11','HUX13','HUX14','HUX16',...
    'HUX4','HUX18','HUX10','HUX12','HUX17','HUX21','HUX22','HUX23','Martina','HUX24',...
    'HUX25','HUX27','HUX28','HUX29','HUX30'}; %,'AshleyDDPI'};HUX17

vfResults = load('C:\Users\Ruccilab\OneDrive - University of Rochester\Documents\Crowding\SummaryDocuments\HuxlinPTFigures\VFs\Scripts\VisualFieldAnalysis\patientInfoMat.mat');

for ii = 1:length(subjectsAll)
    if strcmp('HUX3',subjectsAll{ii})
        huxID{ii} = 'RBG';
    elseif strcmp('HUX5',subjectsAll{ii})
        huxID{ii} = 'JKM';
    elseif strcmp('HUX6',subjectsAll{ii})
        huxID{ii} = 'JMS';
    elseif strcmp('HUX8',subjectsAll{ii})
        huxID{ii} = 'SSS';
    elseif strcmp('HUX1',subjectsAll{ii})
        huxID{ii} = 'RAR';
    elseif strcmp('HUX7',subjectsAll{ii})
        huxID{ii} = 'DBM';
    elseif strcmp('HUX9',subjectsAll{ii})
        huxID{ii} = 'DLF';
    elseif strcmp('HUX11',subjectsAll{ii})
        huxID{ii} = 'SAM';
    elseif strcmp('HUX13',subjectsAll{ii})
        huxID{ii} = 'BPC';
    elseif strcmp('HUX14',subjectsAll{ii})
        huxID{ii} = 'DSA';
    elseif strcmp('HUX16',subjectsAll{ii})
        huxID{ii} = 'MAT';
    elseif strcmp('HUX25',subjectsAll{ii})
        huxID{ii} = 'GXA';
    elseif strcmp('HUX27',subjectsAll{ii})
        huxID{ii} = 'CFJ';
    elseif strcmp('HUX28',subjectsAll{ii})
        huxID{ii} = 'FXH';
    elseif strcmp('HUX29',subjectsAll{ii})
        huxID{ii} = 'RSF';
    elseif strcmp('HUX30',subjectsAll{ii})
        huxID{ii} = 'AXM';
    else
        huxID{ii} = [];
    end
end

%% Figure 3
figure('Position',[2100 0 1500 2500]);

im10 = imread('C:\Users\Ruccilab\Pictures\Screenshots\10-2Example.png');
im30 = imread('C:\Users\Ruccilab\Pictures\Screenshots\30-2Example.png');
ax1 = subplot(6,4,[1 2 5 6]);
imshow(im10)
ax2 = subplot(6,4,[3 4 7 8]);
imshow(im30)
counter = 9;
for ii = 1:height(tableSubjectInfo)
    if tableSubjectInfo.Stroke(ii) == 0
        continue;
    end
    lossIdx = find(vfResults.patientInfo.(huxID{ii}).deficit);
    lossAngles = vfResults.patientInfo.(huxID{ii}).rAngles(lossIdx);
    meanAngleRad = circ_mean(lossAngles');
    rotateAngle = mod(rad2deg(meanAngleRad),360);

    subplot(6,4,counter)
    temp = tableSubjectInfo.vfMap{ii};
    temp(isnan(temp)) = -20;
    
    
    J = imrotate((temp),rotateAngle);
    J(find(J == -20)) = 0;%max(min(J));
    
    imagesc(J);
    axis square;
    set(gca,'XTick',[],'YTick',[])
    
    colormap((gray))
    yticks([1 420])
    xticks([1 540])
    xticklabels({'',''})
    yticklabels({'',''})
    %     end
    
    title(sprintf('P%i',ii));
    
    counter = counter + 1;
    
end
%%
counter = 1;
figure('Position',[2100 0 1500 800]);
for ii = 1:height(tableSubjectInfo)
    if tableSubjectInfo.Stroke(ii) == 0
        continue;
    end
    lossIdx = find(vfResults.patientInfo.(huxID{ii}).deficit);
    lossAngles = vfResults.patientInfo.(huxID{ii}).rAngles(lossIdx);
    meanAngleRad = circ_mean(lossAngles');
    rotateAngle = mod(rad2deg(meanAngleRad),360);
 
    axisVal = 30;
    
    [h, xT] = unique(tableSubjectInfo.fixX{ii});
    v = [tableSubjectInfo.fixX{ii}(xT);tableSubjectInfo.fixY{ii}(xT)]';
    theta = -rotateAngle;
    R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    vRTemp = (v*R);
    idx = find(vRTemp(:,1) < axisVal & vRTemp(:,1) > -axisVal...
        & vRTemp(:,2) < axisVal & vRTemp(:,2) > -axisVal);
    vR = vRTemp(idx,:);
    
    subplot(4,4,counter)
    ptHeatMap{ii} = generateHeatMapSimple( ...
        vR(:,1)', ...
        vR(:,2)', ...
        'Bins', 30,...
        'StimulusSize', 16,...
        'AxisValue', axisVal,...
        'Uncrowded', 0,...
        'Borders', 1);
    
    hold on
    plot([-axisVal axisVal], [0 0], '--k', 'LineWidth',2)
    plot([0 0], [-axisVal axisVal], '--k', 'LineWidth',2)
    
    
    if ii == 1
        ylabel('Degrees')
        xlabel('Degrees')
        
    else
        yticks([1 420])
        xticks([1 540])
        xticklabels({'',''})
        yticklabels({'',''})
    end
    
    title(sprintf('P%i',ii));
    axis square
    counter = counter + 1;
    title(sprintf('P%i',ii));
    
    
end
%% Create Average HeatMap Vectors;
y = [];
y = cat(3,ptHeatMap{:});
ptAll = mean(y,3);

y = [];
y = cat(3,heatMapIm2{:});
ctAll = mean(y,3);


%% Figure 4A
figure('Position',[2100 0 1200 600]);
subplot(1,2,1)

result = ptAll;
pcolor(linspace(-axisVal,axisVal, size(result, 1)),...
    linspace(-axisVal, axisVal, size(result, 1)),...
    result');
shading interp; %interp/flat

%   generateHeatMapSimple( ...
%         [tableSubjectInfo.fixationGroupX{find(tableSubjectInfo.Stroke)'}]  , ...
%         [tableSubjectInfo.fixationGroupY{find(tableSubjectInfo.Stroke)'}]  , ...
%         'Bins', 30,...
%         'StimulusSize', 16,...
%         'AxisValue', axisVal,...
%         'Uncrowded', 0,...
%         'Borders', 1);
    colormap((parula))
hold on
forleg = [];
patientsAllX = [];
patientsAllY = [];
drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} ) ;
x1 = [0 0];
y1 = [5 18];
drawArrow(x1,y1,'linewidth',2,'color','k');
hold on
for ii = find(tableSubjectInfo.Stroke == 1)'
    lossIdx = find(vfResults.patientInfo.(huxID{ii}).deficit);
    lossAngles = vfResults.patientInfo.(huxID{ii}).rAngles(lossIdx);
    meanAngleRad = circ_mean(lossAngles');
    rotateAngle = mod(rad2deg(meanAngleRad),360);
    
    v = [tableSubjectInfo.fixationGroupX{ii};tableSubjectInfo.fixationGroupY{ii}]';
    theta = -rotateAngle;
    R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    vR = v*R;
    
    patientsAllY = [patientsAllY vR(:,2)'];
    patientsAllX = [patientsAllX vR(:,1)'];
    axisVal = 20;
    hold on
    ellipseXY(vR(:,1)', vR(:,2)', 68, [150 150 150]/255,0)
    axis([-axisVal axisVal -axisVal axisVal])
    
    hold on
    plot(0,0,'o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k');
    line([0 0],[-axisVal axisVal],'Color','k','LineWidth',1,'LineStyle',':')
    line([-axisVal axisVal],[0 0],'Color','k','LineWidth',1,'LineStyle',':')
    
    axis square;
    
    set(gca,'XTick',[-20 0 20],'YTick',[-20 0 20],'xlabel',[],'ylabel',[])
    
end
title('Patients')
ellipseXY(patientsAllX, patientsAllY, 65, 'r' ,2)
forleg(1) = plot(mean(patientsAllX),mean(patientsAllY),...
    'd','Color','w','MarkerFaceColor','k')
forleg(2) = plot(0,0,'-','Color',[150 150 150]/255);
legend(forleg,{'Average PLF','68% Countour Ellipse'},'Location','southwest');
text(-1,5,'Blind Field Direction','Rotation',90);

subplot(1,2,2)
result = ctAll;
pcolor(linspace(-axisVal,axisVal, size(result, 1)),...
    linspace(-axisVal, axisVal, size(result, 1)),...
    result');
shading interp; %interp/flat
%  generateHeatMapSimple( ...
%         [tableSubjectInfo.fixationGroupX{find(~tableSubjectInfo.Stroke)'}]  , ...
%         [tableSubjectInfo.fixationGroupY{find(~tableSubjectInfo.Stroke)'}]  , ...
%         'Bins', 30,...
%         'StimulusSize', 16,...
%         'AxisValue', axisVal,...
%         'Uncrowded', 0,...
%         'Borders', 1);
%     colormap(flipud(parula))
    load('./MyColormaps.mat');
    mycmap(1,:) = [1 1 1];
    set(gcf, 'Colormap', mycmap)
    cb = colorbar('Location','north');
    cb.Ticks = ([0.01 0.8]) ; %Create 8 ticks from zero to 1
    cb.TickLabels = ([0 1]) ; 
    ylabel(cb,'Normalized Gaze Distribution','FontSize',12,'Rotation',0)
%     colorbar
%  cbh = colorbar ; %Create Colorbar
%  cbh.Ticks = linspace(0, 0, 8) ; %Create 8 ticks from zero to 1
%  cbh.TickLabels = num2cell([0:1]) ; 
    hold on
patientsAllX = [];
patientsAllY = [];

for ii = find(tableSubjectInfo.Stroke == 0)'
    
    rotateAngle = 0;
    
    v = [tableSubjectInfo.fixationGroupX{ii};tableSubjectInfo.fixationGroupY{ii}]';
    theta = -rotateAngle;
    R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    vR = v*R;
    
    patientsAllY = [patientsAllY vR(:,2)'];
    patientsAllX = [patientsAllX vR(:,1)'];
    axisVal = 20;
    hold on
    ellipseXY(vR(:,1)', vR(:,2)', 68, [150 150 150]/255,0)
    axis([-axisVal axisVal -axisVal axisVal])
    
    hold on
    plot(0,0,'o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k');
    line([0 0],[-axisVal axisVal],'Color','k','LineWidth',1,'LineStyle',':')
    line([-axisVal axisVal],[0 0],'Color','k','LineWidth',1,'LineStyle',':')
    
    axis square;
    
    set(gca,'XTick',[-20 0 20],'YTick',[-20 0 20],'xlabel',[],'ylabel',[])
    %         title(sprintf('%s',subjectsAll{ii}));
    
end
title('Controls')
ellipseXY(patientsAllX, patientsAllY, 65, 'r' ,2)
plot(mean(patientsAllX),mean(patientsAllY),'d','Color','w','MarkerFaceColor','k')



%% Figure3B and C

[pY_FullFixation, meanValsCL, meanValsPT, meansValsIndY] = ...
    histogramNormalizedForRotation(1:26, ~tableSubjectInfo.Stroke, ...
    tableSubjectInfo.allRotated,...
    tableSubjectInfo.allRotated, 2, 0); %x = 1 or y = 2
text([25],[.5],'Blind Field ->','Fontsize',12,'FontWeight','bold','Color','b')
xlabel('Arcminute Offset')


[pY_500Fixation, meanValsCL500Y, meanValsPT500Y, meansValsInd500Y] = ...
    histogramNormalizedForRotation(1:26, ~tableSubjectInfo.Stroke, ...
    tableSubjectInfo.allRotated500,...
    tableSubjectInfo.allRotated500, 2, 0); %x = 1 or y = 2
text([25],[.5],'Blind Field ->','Fontsize',12,'FontWeight','bold','Color','b')
xlabel('Arcminute Offset')

figure;
forlegs(1) = errorbar([1 2],[meanValsCL.mean meanValsPT.mean],[meanValsCL.sem meanValsPT.sem],...
    'o');
xlim([.1 2.9])
ylim([-5 5])
hold on
forlegs(2) =errorbar([1.1 2.1],[meanValsCL500Y.mean meanValsPT500Y.mean],[meanValsCL500Y.sem meanValsPT500Y.sem],...
    'o');
title('');
ylabel('Arcmin Toward Blind Field')
xticks([1 2])
xticklabels({'Control','Patient'});
x1 = [2.5 2.5];
y1 = [0 4];
drawArrow(x1,y1,'linewidth',2,'color','k');
legend(forlegs,{'5 s','500 ms'},'Location','southeast');
text(2.4,1,'Blind Field','Rotation',90);

[h,p,~,sts] = ttest(meansValsInd500Y(tableSubjectInfo.Stroke == 0),...
    meansValsIndY(tableSubjectInfo.Stroke == 0))

[h,p,~,sts] = ttest(meansValsInd500Y(tableSubjectInfo.Stroke == 1),...
    meansValsIndY(tableSubjectInfo.Stroke == 1))

%% Figure 4 MS Fixation

subNum = length(subjectsAll);
prl.x = [-3.6235213,-1.9011810,1.6922642,9.1925192,0.31330070,-3.4936483,1.2013147,-1.5845748,7.2855325,-2.6934733,-1.3505460,4.2888293,0.63825506,4.4881263,-6.6085296,2.1053123,1.7794517,0.053696334,-0.16159466,6.2817893,-0.12630363,-4.0137539,-12.460599,-2.5793967,-3.1131990,-3.8910515];
prl.y = [3.4364948,2.8098791,2.8107243,-0.28045452,6.5732045,7.8145442,9.4996395,4.3779044,-1.4699855,1.1341612,9.6747885,-2.4013331,-6.1710248,4.3945508,-5.3797216,0.89892393,3.0521350,2.3207297,-4.5593548,8.0076065,-3.8920093,5.6634879,-0.077674948,0.98524725,-1.5957737,4.2907729];

% %% Microsaccade Data Task
% % for ii = 1:subNum
%     if strcmp(subjectsAll{ii}, 'HUX5') || strcmp(subjectsAll{ii}, 'HUX27')
%         msTask{ii}.msAmplitude = NaN;
%         msTask{ii}.msAngle = NaN;
%         msTask{ii}.msRate = NaN;
%         msTask{ii}.msPattern = NaN;
%         msTask{ii}.msPosition = NaN;
%         continue;
%     end
%     msAmplitude = [];
%     msAngle = [];
%     msPosition = [];
%     msRate = [];
%     msPattern = [];
%     msStartX = []; msEndX = []; msStartY = []; msEndY = [];
%     path = [];
%     names = [];
%     counter = 1; trialCounter = 1;
%     names = fieldnames(subjectThreshUnc(ii).em.msAnalysis);
%     for n = 1:length(names)
%         path = subjectThreshUnc(ii).em.msAnalysis.(names{n});
%         if isfield(path, 'position')
%             for i = 1:length(path.position)
%                 for j = 1:length(path.MicroSaccStartLoc(i).x)
%                     if path.msStartTime{i}(j) < 400 ||...
%                             path.msStartTime{i}(j) > 900
%                         continue
%                     end
%                     msStartX = [msStartX...
%                         path.MicroSaccStartLoc(i).x(j)];
%                     msStartY = [msStartY...
%                         path.MicroSaccStartLoc(i).y(j)];
%                     msEndX = [msEndX...
%                         path.MicroSaccEndLoc(i).x(j)];
%                     msEndY = [msEndY...
%                         path.MicroSaccEndLoc(i).y(j)];
%                     msRate = [msRate...
%                         path.microsaccadeRate(i)];
%                     msAmplitude = [msAmplitude...
%                         eucDist(...
%                         path.MicroSaccStartLoc(i).x(j)-path.MicroSaccEndLoc(i).x(j), ...
%                         path.MicroSaccStartLoc(i).y(j)-path.MicroSaccEndLoc(i).y(j))];
%                     msAngle = [msAngle...
%                         atan2d(...
%                         path.MicroSaccStartLoc(i).y(j)-path.MicroSaccEndLoc(i).y(j), ...
%                         path.MicroSaccStartLoc(i).x(j)-path.MicroSaccEndLoc(i).x(j))];
%                     counter = counter + 1;
%                 end
%                 %                 if counter > 1
%                 
%                 %                 msAngle = [msAngle...
%                 %                     path.msAngle];
%                 msPosition{1,trialCounter} = path.position(i).x{1};
%                 msPosition{2,trialCounter} = path.position(i).y{1};
%                 
%                 trialCounter = trialCounter + 1;
%                 %                 end
%             end
%         end
%         
%     end
%     %     msIdx = find(~isnan(msStartX) & ~isnan(msStartY) &...
%     %         ~isnan(msEndX) & ~isnan(msEndY))
%     msTask{ii}.msAmplitude = msAmplitude;
%     msTask{ii}.msAngle = msAngle;
%     msTask{ii}.msRate = mean(msRate(msRate < 5));
%     msTask{ii}.msPattern = msPattern;
%     msTask{ii}.msPosition = msPosition;
%     msTask{ii}.msStart(1,:) =  msStartX;
%     msTask{ii}.msStart(2,:) =  msStartY;
%     msTask{ii}.msEnd(1,:) = msEndX;
%     msTask{ii}.msEnd(2,:) = msEndY;
%     
%     %     for i = 1:length(fixationInfo{ii}.tracesX)
%     %         findMSandSPostProcess(pptrials,i)
%     %     end
% end

%% MS Data Combine Fix and Task

load('MATFiles/MSFixationResultsHuxlin2.mat') %msFix from runHuxFixAnalysis


% orangize ms based on first, second, etc in trial Fixation
for ii = 1:subNum
    for i = 1:length(msFix{ii}.MicroSaccStartLoc)
        for m = 1:length(msFix{ii}.msAngle{i})
            msFix{ii}.msAngleStruct(i,m) = atan2d(...
                msFix{ii}.MicroSaccStartLoc(i).y(m)-msFix{ii}.MicroSaccEndLoc(i).y(m), ...
                msFix{ii}.MicroSaccStartLoc(i).x(m)-msFix{ii}.MicroSaccEndLoc(i).x(m));
            msFix{ii}.msAmpStruc(i,m)= msFix{ii}.msAmplitude{i}(m);
        end
    end
    msFix{ii}.msAngleStruct((msFix{ii}.msAngleStruct==0)) = NaN;
    msFix{ii}.msAmpStruc((msFix{ii}.msAmpStruc==0)) = NaN;
end


for ii = find(tableSubjectInfo.Stroke)'
    lossIdx = find(vfResults.patientInfo.(huxID{ii}).deficit);
    lossAngles = vfResults.patientInfo.(huxID{ii}).rAngles(lossIdx);
    meanAngleRad = circ_mean(lossAngles');
    rotateAngle = mod(rad2deg(meanAngleRad),360);
    theta = rotateAngle;
    R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    msFix{ii}.msAngleStructRotate = mod(msFix{ii}.msAngleStruct + theta,360);
end

msAllAnalysis.fixation = msFix;
% save('msAllAnalysis.mat','msAllAnalysis')

values = [];
msThreshold = 5;
rotateExtra = 0;
majorAxis = 0:15:330;

%%Clean Up MS Based on Angle and Amp.
%%%fixation
for ii = 1:length(subjectsAll) %getALLMS in one vector
    tempX = []; tempY = []; temp1 = []; temp2 = []; temp3 = []; temp4 = [];
    for i = 1:length(msFix{ii}.MicroSaccEndLoc)
        tempX = [tempX msFix{ii}.MicroSaccEndLoc(i).x - msFix{ii}.MicroSaccStartLoc(i).x];
        tempY = [tempY msFix{ii}.MicroSaccEndLoc(i).y - msFix{ii}.MicroSaccStartLoc(i).y];
        temp1 = [temp1 msFix{ii}.MicroSaccStartLoc(i).x];
        temp2 = [temp2 msFix{ii}.MicroSaccStartLoc(i).y];
        temp3 = [temp3 msFix{ii}.MicroSaccEndLoc(i).x];
        temp4 = [temp4 msFix{ii}.MicroSaccEndLoc(i).y];
    end
    idx = find(abs(eucDist(tempX,tempY)) < 30);
    msAllAnalysis.fixation{ii}.msAllXCorrected = tempX(idx);
    msAllAnalysis.fixation{ii}.msAllYCorrected = tempY(idx);
    msAllAnalysis.fixation{ii}.msAllCorrectedIdx = idx;
    msAllAnalysis.fixation{ii}.msAllCleanS(1,:) = temp1(idx);
    msAllAnalysis.fixation{ii}.msAllCleanS(2,:) = temp2(idx);
    msAllAnalysis.fixation{ii}.msAllCleanE(1,:) = temp3(idx);
    msAllAnalysis.fixation{ii}.msAllCleanE(2,:) = temp4(idx);
    
    x2 = tempX(idx);
    y2 = tempY(idx);
    msAllAnalysis.fixation{ii}.msAngleCorrected = ...
        atan2d(y2,x2);
    
    msAllAnalysis.fixation{ii}.msAmpCorrected = ...
        hypot(y2,x2);
    
    idx = find(abs(eucDist(tempX,tempY)) >= 30 & eucDist(tempX,tempY) < 500);
    sAllAnalysis.fixation{ii}.sAllXCorrected = tempX(idx);
    sAllAnalysis.fixation{ii}.sAllYCorrected = tempY(idx);
    sAllAnalysis.fixation{ii}.sAllCorrectedIdx = idx;
    x2 = tempX(idx);
    y2 = tempY(idx);
    sAllAnalysis.fixation{ii}.sAngleCorrected = ...
        atan2d(y2,x2);
    sAllAnalysis.fixation{ii}.sAmpCorrected = ...
        hypot(y2,x2);
end

%%% roated fix
for ii = find(tableSubjectInfo.Stroke)'
    lossIdx = find(vfResults.patientInfo.(huxID{ii}).deficit);
    lossAngles = vfResults.patientInfo.(huxID{ii}).rAngles(lossIdx);
    meanAngleRad = circ_mean(lossAngles');
    rotateAngle = mod(rad2deg(meanAngleRad),360);
    theta = rotateAngle;
    
    R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    
    v = [msAllAnalysis.fixation{ii}.msAllXCorrected;... %%%MS Fixation
        msAllAnalysis.fixation{ii}.msAllYCorrected]';
    rotatedAligned.fix{ii} = v*R;
    rotatedAligned.msAngleCorrectedFix{ii} = ...
        atan2d(rotatedAligned.fix{ii}(:,2),rotatedAligned.fix{ii}(:,1));
    
    
    v = [msAllAnalysis.fixation{ii}.msAllCleanS(1,:);... %ms start fix
        msAllAnalysis.fixation{ii}.msAllCleanS(2,:)]';
    rotatedAligned.msSfixation{ii} = v*R;
    
    v = [msAllAnalysis.fixation{ii}.msAllCleanE(1,:);...%MS end fix
        msAllAnalysis.fixation{ii}.msAllCleanE(2,:)]';
    rotatedAligned.msEfixation{ii} = v*R;
    
    v = [sAllAnalysis.fixation{ii}.sAllXCorrected;... %%%S Fixation
        sAllAnalysis.fixation{ii}.sAllYCorrected]';
    rotatedAligned.sfix{ii} = v*R;
    rotatedAligned.sAngleCorrectedFix{ii} = ...
        atan2d(rotatedAligned.sfix{ii}(:,2),rotatedAligned.sfix{ii}(:,1));
end

for ii = 1:length(subjectsAll)
    %     msAll.msRateT(ii) = msTask{ii}.msRate;
    msAll.msRateF(ii) = mean(msFix{ii}.msRates(msFix{ii}.msRates > 0));
end

%
[h,p] = ttest2(msAll.msRateF(find(~tableSubjectInfo.Stroke)'),...
    msAll.msRateF(find(tableSubjectInfo.Stroke)'))

%
values = [];
msThreshold = 5;
rotateExtra = 0;
majorAxis = 0:15:330;

ii = 1;
for t = find(~tableSubjectInfo.Stroke)'
    theta_deg = [];
    theta_radians = [];
    theta_deg = mod(msAllAnalysis.fixation{t}.msAngleCorrected(...
        msAllAnalysis.fixation{t}.msAmpCorrected > msThreshold),360);
    theta_radians = deg2rad(theta_deg);
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals{ii,i} = (theta_deg < 15 & theta_deg >= 0) | ...
                theta_deg > 345;
        else
            vecVals{ii,i} = (theta_deg < majorAxis(i) + 15 &...
                theta_deg > majorAxis(i)-15);
        end
        values(ii,i) = length(find(vecVals{ii,i}));
        SEMVal(ii,i) = sem(normalizeVector(theta_deg(theta_deg < majorAxis(i) + 15 &...
            theta_deg > majorAxis(i)-15)));
    end
    ii = 1+ii;
end

rho = normalizeVector(mean(values));% (values(1))]); % change this vector (it is a vector of 8, and then add the first value to the end  to connect the polar plot )
msNum.Controls = values;
msNum.Angles = majorAxis;

values2 = [];
% save('HuxMsNums.mat','msNum');
ii = 1;
for t = find(tableSubjectInfo.Stroke)'
    theta_deg = mod(msAllAnalysis.fixation{t}.msAngleCorrected(...
        msAllAnalysis.fixation{t}.msAmpCorrected > msThreshold),360);
    theta_radians = deg2rad(theta_deg);
  
    theta_radians = deg2rad(theta_deg);
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals2{ii,i} = ((theta_deg < 15 & theta_deg >= 0) | ...
                theta_deg > 345);
        else
            vecVals2{ii,i} = (theta_deg < majorAxis(i) + 15 &...
                theta_deg > majorAxis(i)-15);
        end
        values2(ii,i) = length(find(vecVals2{ii,i}));
        
%         vecVals3{ii,i} = (theta_degNonRot < majorAxis(i) + 15 &...
%             theta_degNonRot > majorAxis(i)-15);
%         values3(ii,i) = length(find(vecVals3{ii,i}));
        SEMVal(ii,i) = sem((theta_deg(theta_deg < majorAxis(i) + 15 &...
            theta_deg > majorAxis(i)-15)));
    end
    ii = 1+ii;
end
hold on
rho2 = normalizeVector(mean(values2));
msNum.Patients2 = values2;
% msNum.notRotatedPatients = values3;

values2 = [];
% save('HuxMsNums.mat','msNum');
ii = 1;
for t = find(tableSubjectInfo.Stroke)'
    theta_deg = [];
    theta_radians = [];
    theta_deg = mod(rotatedAligned.msAngleCorrectedFix{t}(...
        msAllAnalysis.fixation{t}.msAmpCorrected > msThreshold),360)'+rotateExtra;
    if rotateExtra ~= 0
        idx = (find(theta_deg>360)); theta_deg(idx) = theta_deg(idx) - 360;
    end
    theta_degNonRot = mod(msAllAnalysis.fixation{t}.msAngleCorrected(...
        msAllAnalysis.fixation{t}.msAmpCorrected > msThreshold),360)';
    
    theta_radians = deg2rad(theta_deg);
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals2{ii,i} = ((theta_deg < 15 & theta_deg >= 0) | ...
                theta_deg > 345);
        else
            vecVals2{ii,i} = (theta_deg < majorAxis(i) + 15 &...
                theta_deg > majorAxis(i)-15);
        end
        values2(ii,i) = length(find(vecVals2{ii,i}));
        
        vecVals3{ii,i} = (theta_degNonRot < majorAxis(i) + 15 &...
            theta_degNonRot > majorAxis(i)-15);
        values3(ii,i) = length(find(vecVals3{ii,i}));
        SEMVal(ii,i) = sem((theta_deg(theta_deg < majorAxis(i) + 15 &...
            theta_deg > majorAxis(i)-15)));
    end
    ii = 1+ii;
end
hold on
rho2 = normalizeVector(mean(values2));
msNum.Patients = values2;
% msNum.notRotatedPatients = values3;

P2 = msNum.Patients2./max(msNum.Patients2')';
P = msNum.Patients./max(msNum.Patients')';
C = msNum.Controls./max(msNum.Controls')';


for ii = 1:length(find(tableSubjectInfo.Stroke)')
    P(ii,:) = msNum.Patients(ii,:)/sum(msNum.Patients(ii,:));
end
%     C = dNum.Controls./max(dNum.Controls')';
for ii = 1:length(find(~tableSubjectInfo.Stroke)')
    C(ii,:) = msNum.Controls(ii,:)/sum(msNum.Controls(ii,:));
end
for ii = 1:length(find(tableSubjectInfo.Stroke)')
    P2(ii,:) = msNum.Patients2(ii,:)/sum(msNum.Patients2(ii,:));
end


forlegs = [];
figure;
% subplot(1,2,1)
forlegs(1) = polarplot(deg2rad([majorAxis 0]),[mean(P2) mean(P2(:,1))],'-','Color','b'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(P2)+sem(P2) mean(P2(:,1))+sem(P2(:,1))],':','Color','b');hold on
polarplot(deg2rad([majorAxis 0]),[mean(P2)-sem(P2) mean(P2(:,1))-sem(P2(:,1))],':','Color','b')
% title('Probability of MS Direction');
hold on
% subplot(1,2,2)
forlegs(2) = polarplot(deg2rad([majorAxis 0]),[mean(C) mean(C(:,1))],'-','Color','r'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(C)+sem(C) mean(C(:,1))+sem(C(:,1))],':','Color','r');hold on
polarplot(deg2rad([majorAxis 0]),[mean(C)-sem(C) mean(C(:,1))-sem(C(:,1))],':','Color','r')
% title('Probability of MS Direction Controls');
legend(forlegs,{'Patient','Control'});

figure ('Position',[2100,0,1000,500]);
subplot(1,2,1)
polarplot(deg2rad([majorAxis 0]),[mean(P) mean(P(:,1))],'-','Color','k'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(P)+sem(P) mean(P(:,1))+sem(P(:,1))],':','Color',[.2 .2 .2]);hold on
polarplot(deg2rad([majorAxis 0]),[mean(P)-sem(P) mean(P(:,1))-sem(P(:,1))],':','Color',[.2 .2 .2])
title('Probability of MS Direction');

subplot(1,2,2)
upMat = [P(:,5),P(:,6),P(:,7),P(:,8),P(:,9)];
up = [P(:,5)',P(:,6)',P(:,7)',P(:,8)',P(:,9)']/16;
downMat = [P(:,17),P(:,18),P(:,19),P(:,20),P(:,21)];
down = [P(:,17)',P(:,18)',P(:,19)',P(:,20)',P(:,21)']/16;
left = [P(:,10)',P(:,11)',P(:,12)',P(:,13)',P(:,14)',P(:,15)',P(:,16)']/16;
right = [P(:,1)',P(:,2)',P(:,3)',P(:,4)',P(:,22)',P(:,23)']/16;

eachSubjUp = sum(upMat');
eachSubjDo = sum(downMat');
for i = 1:size(upMat)
    plot([0 1],[eachSubjUp(i) eachSubjDo(i)],'--','Color',[.3 .3 .3])
    hold on
end

errorbar([0 1],[sum(up) sum(down)],...
    [sem(sum(upMat')),sem(sum(downMat'))],'-o',...
    'Color','k','MarkerFaceColor','k','MarkerSize',10);
hold on
errorbar([2 3],[mean([P(:,6)' P(:,7)' P(:,8)']) mean([P(:,1)' P(:,2)' P(:,12)'])],...
    [sem([P(:,6)' P(:,7)' P(:,8)']) sem([P(:,1)' P(:,2)' P(:,12)'])],'-o',...
    'Color','b','MarkerFaceColor','b','MarkerSize',10);
ylabel('Probability of MS Direction');
xticks([0 1])
% xtickslabels({'Towards BF
xlim([-.25 1.25])
xticklabels({'Towards BF','Away from BF'});
[h,p,~,sts] = ttest(sum(upMat'),sum(downMat'));
title(sprintf('p = %.3f',p));
set(gca,'FontSize',14);

%%
load('msAllAnalysis.mat')

% msAllAnalysis.task = msTask;
% msAllAnalysis.ID = subjectsAll;
% msAllAnalysis.PT = (~tableSubjectInfo.Stroke);

% load('rotatedAligned.mat');
%
values = [];
msThreshold = 5;
rotateExtra = 0;
majorAxis = 0:15:330;

ii = 1;
for t = (find(tableSubjectInfo.Stroke == 1))'
    theta_deg = [];
    theta_radians = [];
    theta_deg = reshape(msAllAnalysis.fixation{t}.msAngleStructRotate,1,[]);
    theta_degNonRot = reshape(msAllAnalysis.fixation{t}.msAngleStruct,1,[]);

    theta_radians = deg2rad(theta_deg);
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals2{ii,i} = ((theta_deg < 15 & theta_deg >= 0) | ...
                theta_deg > 345);
        else
            vecVals2{ii,i} = (theta_deg < majorAxis(i) + 15 &...
                theta_deg > majorAxis(i)-15);
        end
        values2(ii,i) = length(find(vecVals2{ii,i}));

        vecVals3{ii,i} = (theta_degNonRot < majorAxis(i) + 15 &...
            theta_degNonRot > majorAxis(i)-15);
        values3(ii,i) = length(find(vecVals3{ii,i}));
        SEMVal(ii,i) = sem((theta_deg(theta_deg < majorAxis(i) + 15 &...
            theta_deg > majorAxis(i)-15)));
    end
    ii = 1+ii;
end
hold on
rho2 = normalizeVector(mean(values2));
msNum.Patients = values2;
msNum.notRotatedPatients = values3;

ii = 1;
for t = (find(tableSubjectInfo.Stroke == 0))'
    theta_deg = [];
    theta_radians = [];
    theta_deg = reshape(msAllAnalysis.fixation{t}.msAngleStruct,1,[]);
    theta_radians = deg2rad(theta_deg);
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals2{ii,i} = ((theta_deg < 15 & theta_deg >= 0) | ...
                theta_deg > 345);
        else
            vecVals2{ii,i} = (theta_deg < majorAxis(i) + 15 &...
                theta_deg > majorAxis(i)-15);
        end
        values2(ii,i) = length(find(vecVals2{ii,i}));

        SEMVal(ii,i) = sem((theta_deg(theta_deg < majorAxis(i) + 15 &...
            theta_deg > majorAxis(i)-15)));
    end
    ii = 1+ii;
end
msNum.Controls = values2;
msNum.Angles = majorAxis;

P = msNum.Patients./max(msNum.Patients')';
C = msNum.Controls./max(msNum.Controls')';

for ii = 1:(find(tableSubjectInfo.Stroke == 1))'
    P(ii,:) = msNum.Patients(ii,:)/sum(msNum.Patients(ii,:));
end
%     C = dNum.Controls./max(dNum.Controls')';
for ii = 1:(find(tableSubjectInfo.Stroke == 0))'
    C(ii,:) = msNum.Controls(ii,:)/sum(msNum.Controls(ii,:));
end

[h,p,~,sts] = ttest(mean([P(:,5:9)']), mean([P(:,17:21)'])); %look at up and down +- 30deg

figure;
errorbar([0 1],[mean(sum([P(:,5:9)'])) mean(sum([P(:,17:21)']))],...
    [sem(sum([P(:,5:9)'])) sem(sum([P(:,17:21)']))],'-o');
ylabel('Probability of MS Direction');
xticks([0 1])
xlim([-.25 1.25])
xticklabels({'Towards BF','Away from BF'});
title('p = ',round(p,3))
set(gca,'FontSize',14);

figure;
polarplot(deg2rad([majorAxis 0]),[mean(P) mean(P(:,1))],'-o'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(P)+sem(P) mean(P(:,1))+sem(P(:,1))],'--');hold on
polarplot(deg2rad([majorAxis 0]),[mean(P)-sem(P) mean(P(:,1))-sem(P(:,1))],'--')
title('Probability of MS Direction');

upMat = [P(:,5),P(:,6),P(:,7),P(:,8),P(:,9)];
up = [P(:,5)',P(:,6)',P(:,7)',P(:,8)',P(:,9)']/16;
downMat = [P(:,17),P(:,18),P(:,19),P(:,20),P(:,21)];
down = [P(:,17)',P(:,18)',P(:,19)',P(:,20)',P(:,21)']/16;
left = [P(:,10)',P(:,11)',P(:,12)',P(:,13)',P(:,14)',P(:,15)',P(:,16)']/16;
right = [P(:,1)',P(:,2)',P(:,3)',P(:,4)',P(:,22)',P(:,23)']/16;
[h,p,~,sts] = ttest(sum(upMat'),sum(downMat'));

for ii = 1:26
    if ii == 3
        continue;
    end
    counter = 1;ampFix=[];
    for i = 1:length(msFix{ii}.msAmplitude)
        idx = (msFix{ii}.msAmplitude{counter} < 30 &...
            msFix{ii}.msAmplitude{counter} > 3);
        ampFix(counter) = nanmean(msFix{ii}.msAmplitude{counter}(idx));
        counter = counter + 1;
    end
    tIdx = (msAllAnalysis.task{ii}.msAmplitude < 30 &...
         msAllAnalysis.task{ii}.msAmplitude > 3);
    if sum(tIdx) == 0
        amplTask(ii) = NaN;
    else
        amplTask(ii) = nanmean(msAllAnalysis.task{ii}.msAmplitude(tIdx));
    end
    amplFix(ii) = nanmean(ampFix);
    numMSFitTask(ii) = length(find(tIdx))
end
[h,p]=ttest(amplTask,amplFix)
figure;
errorbar([1 2],[nanmean(amplTask) nanmean(amplFix)],...
    [nanstd(amplTask) nanstd(amplFix)],...
    '-o','Color','k');
xticks([1 2])
xticklabels({'Task','Fixation'});
xlim([0 3])
ylabel('Average Microsaccade Amplitude');
    
%% Figure 4 Drift Fixation
load('huxlinDriftFixation.mat')
subNum = height(tableSubjectInfo);
majorAxis = 0:15:330;
dNum = [];
figure;
subplot(1,3,1)
counter = 1;
values = [];
for ii = find(~tableSubjectInfo.Stroke)'
    allDriftAngle = [];
    polarhistogram(deg2rad([avDirection{ii,:}]));
    allDriftAngle = mod([avDirection{ii,:}],360);
    hold on
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals{ii,i} = (allDriftAngle < 15 & allDriftAngle >= 0) | ...
                allDriftAngle > 345;
        else
            vecVals{ii,i} = (allDriftAngle < majorAxis(i) + 15 &...
                allDriftAngle > majorAxis(i)-15);
        end
        values(counter,i) = length(find(vecVals{ii,i}));
        SEMVal(counter,i) = sem(normalizeVector(allDriftAngle(allDriftAngle < majorAxis(i) + 15 &...
            allDriftAngle > majorAxis(i)-15)));
    end
    counter = counter + 1;
end
rho = normalizeVector(mean(values));% (values(1))]); % change this vector (it is a vector of 8, and then add the first value to the end  to connect the polar plot )
dNum.Controls = values;
dNum.Angles = majorAxis;
subtitle('Control');

subplot(1,3,2)
counter = 1;
values = [];
for ii = find(tableSubjectInfo.Stroke)'
    allDriftAngle = [];
    polarhistogram(deg2rad([avDirection{ii,:}]));
    allDriftAngle = mod([avDirection{ii,:}],360);
    hold on
    for i = 1:length(majorAxis)
        if majorAxis(i) == 0
            vecVals{ii,i} = (allDriftAngle < 15 & allDriftAngle >= 0) | ...
                allDriftAngle > 345;
        else
            vecVals{ii,i} = (allDriftAngle < majorAxis(i) + 15 &...
                allDriftAngle > majorAxis(i)-15);
        end
        values(counter,i) = length(find(vecVals{ii,i}));
        SEMVal(counter,i) = sem(normalizeVector(allDriftAngle(allDriftAngle < majorAxis(i) + 15 &...
            allDriftAngle > majorAxis(i)-15)));
    end
    counter = counter + 1;
end
rho = normalizeVector(mean(values));% (values(1))]); % change this vector (it is a vector of 8, and then add the first value to the end  to connect the polar plot )
dNum.Patients2 = values;
dNum.Angles = majorAxis;
subtitle('Patient Not Rotated');

subplot(1,3,3)
counter = 1;
for ii = find(tableSubjectInfo.Stroke)'
    allDriftAngleRot = [];
    lossIdx = find(vfResults.patientInfo.(huxID{ii}).deficit);
    lossAngles = vfResults.patientInfo.(huxID{ii}).rAngles(lossIdx);
    meanAngleRad = circ_mean(lossAngles');
    rotateAngle = mod(rad2deg(meanAngleRad),360);
    theta = rotateAngle;
    avDir360 = mod([avDirection{ii,:}],360);
    allDriftAngleRot = mod(avDir360+theta,360);
    polarhistogram(allDriftAngleRot);
    hold on
    for i = 1:length(majorAxis)
        
        if majorAxis(i) == 0
            vecVals{ii,i} = (allDriftAngleRot < 15 & allDriftAngleRot >= 0) | ...
                allDriftAngleRot > 345;
        else
            vecVals{ii,i} = (allDriftAngleRot < majorAxis(i) + 15 &...
                allDriftAngleRot > majorAxis(i)-15);
        end
        values(counter,i) = length(find(vecVals{ii,i}));
        SEMVal(counter,i) = sem(normalizeVector(allDriftAngleRot(allDriftAngleRot < majorAxis(i) + 15 &...
            allDriftAngleRot > majorAxis(i)-15)));
    end
    counter = counter + 1;
    
end
rho = normalizeVector(mean(values));% (values(1))]); % change this vector (it is a vector of 8, and then add the first value to the end  to connect the polar plot )
subtitle('PT Rotated');

dNum.Patients = values;
dNum.Angles = majorAxis;

for ii = 1:length(find(~control))
    P(ii,:) = dNum.Patients(ii,:)/sum(dNum.Patients(ii,:));
end
for ii = 1:length(find(control))
    C(ii,:) = dNum.Controls(ii,:)/sum(dNum.Controls(ii,:));
end

for ii = 1:length(find(~control))
    P2(ii,:) = dNum.Patients2(ii,:)/sum(dNum.Patients2(ii,:));
end
% [h,p] = ttest(mean([P(:,1:11)']), mean([P(:,13:23)'])); %divide in half
% 
% [h,p] = ttest(mean([P(:,5:9)']), mean([P(:,17:21)'])); %look at up and down +- 30deg
% 
% figure;
% errorbar([0 1],[mean(sum([P(:,5:9)'])) mean(sum([P(:,17:21)']))],...
%     [sem(sum([P(:,5:9)'])) sem(sum([P(:,17:21)']))],'-o');
% ylabel('Probability of MS Direction');
% xticks([0 1])
% xlim([-.25 1.25])
% xticklabels({'Towards BF','Away from BF'});
% title('p = ',round(p,3))
% set(gca,'FontSize',14);

% figure;
% polarplot(deg2rad([majorAxis 0]),[mean(P) mean(P(:,1))],'-o'); hold on
% polarplot(deg2rad([majorAxis 0]),[mean(P)+sem(P) mean(P(:,1))+sem(P(:,1))],'--');hold on
% polarplot(deg2rad([majorAxis 0]),[mean(P)-sem(P) mean(P(:,1))-sem(P(:,1))],'--')
% title('Probability of Drift Direction');

forlegs = [];
figure;
% subplot(1,2,1)
forlegs(1) = polarplot(deg2rad([majorAxis 0]),[mean(P2) mean(P2(:,1))],'-','Color','b'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(P2)+sem(P2) mean(P2(:,1))+sem(P2(:,1))],':','Color','b');hold on
polarplot(deg2rad([majorAxis 0]),[mean(P2)-sem(P2) mean(P2(:,1))-sem(P2(:,1))],':','Color','b')
% title('Probability of Drift Direction');

% subplot(1,2,2)
forlegs(2) = polarplot(deg2rad([majorAxis 0]),[mean(C) mean(C(:,1))],'-','Color','r'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(C)+sem(C) mean(C(:,1))+sem(C(:,1))],':','Color','r');hold on
polarplot(deg2rad([majorAxis 0]),[mean(C)-sem(C) mean(C(:,1))-sem(C(:,1))],':','Color','r')
% title('Probability of Drift Direction Controls');
legend(forlegs,{'Patient','Control'});

figure ('Position',[2100,0,1000,500]);
subplot(1,2,1)
polarplot(deg2rad([majorAxis 0]),[mean(P) mean(P(:,1))],'-','Color','k'); hold on
polarplot(deg2rad([majorAxis 0]),[mean(P)+sem(P) mean(P(:,1))+sem(P(:,1))],':','Color',[.2 .2 .2]);hold on
polarplot(deg2rad([majorAxis 0]),[mean(P)-sem(P) mean(P(:,1))-sem(P(:,1))],':','Color',[.2 .2 .2])
title('Probability of Drift Direction');


subplot(1,2,2)
upMat = [P(:,5),P(:,6),P(:,7),P(:,8),P(:,9)];
up = [P(:,5)',P(:,6)',P(:,7)',P(:,8)',P(:,9)']/16;
downMat = [P(:,17),P(:,18),P(:,19),P(:,20),P(:,21)];
down = [P(:,17)',P(:,18)',P(:,19)',P(:,20)',P(:,21)']/16;
left = [P(:,10)',P(:,11)',P(:,12)',P(:,13)',P(:,14)',P(:,15)',P(:,16)']/16;
right = [P(:,1)',P(:,2)',P(:,3)',P(:,4)',P(:,22)',P(:,23)']/16;

eachSubjUp = sum(upMat');
eachSubjDo = sum(downMat');
for i = 1:size(upMat)
    plot([0 1],[eachSubjUp(i) eachSubjDo(i)],'--','Color',[.3 .3 .3])
    hold on
end

errorbar([0 1],[sum(up) sum(down)],...
    [sem(sum(upMat')),sem(sum(downMat'))],'-o',...
    'Color','k','MarkerFaceColor','k','MarkerSize',10);
hold on
errorbar([2 3],[mean([P(:,6)' P(:,7)' P(:,8)']) mean([P(:,1)' P(:,2)' P(:,12)'])],...
    [sem([P(:,6)' P(:,7)' P(:,8)']) sem([P(:,1)' P(:,2)' P(:,12)'])],'-o',...
    'Color','b','MarkerFaceColor','b','MarkerSize',10);
ylabel('Probability of MS Direction');
xticks([0 1])
% xtickslabels({'Towards BF
xlim([-.25 1.25])
xticklabels({'Towards BF','Away from BF'});
[h,p,~,st] = ttest(sum(upMat'),sum(downMat'));
title(sprintf('p = %.3f',p));
set(gca,'FontSize',14);
%%
[~,~,stats] = anovan(mean([msNum.Patients2',...
       msNum.Controls']),{control});
multcompare(stats)

[~,~,stats] = anovan(mean([dNum.Patients2',...
       dNum.Controls']),{control});
multcompare(stats)

%% Sanity Check - Velocity Check of Drift
% % % % for ii = find(tableSubjectInfo.Stroke)'
% % % %     figure;
% % % %     ax1 = subplot(1,2,1);
% % % %     heatmpaOutPut{i} = ndhist([dataStruct{ii}.instSpX{:}], ...
% % % %         [dataStruct{ii}.instSpY{:}],'bins', 2, 'radial','axis',[-200 200 -200 200],'nr','filt');
% % % %     axis([-60 60 -60 60])
% % % %     load('./MyColormaps.mat')
% % % %     set(gcf, 'Colormap', mycmap)
% % % %     axis square
% % % %     line([-60 60],[0 0])
% % % %     line([0 0],[-60 60])
% % % %     shading interp
% % % %     
% % % %     ax2 = subplot(1,2,2);
% % % %     
% % % %     temp = tableSubjectInfo.vfMap{ii};
% % % %     temp(isnan(temp)) = -20;
% % % %     
% % % %     J = imrotate((temp),0);
% % % %     J(find(J == -20)) = max(max(J));
% % % %     
% % % %     imagesc(J);
% % % %     axis square;
% % % %     set(gca,'XTick',[],'YTick',[])
% % % %     colormap((gray))
% % % %     title(sprintf('S%i',ii))
% % % %     colormap(ax1,mycmap)
% % % % end
% % % % 
% % % % for ii = find(~tableSubjectInfo.Stroke)'
% % % %     figure;
% % % %     %     ax1 = subplot(10,2,counter)
% % % %     %         ax1 = subplot(1,2,1);
% % % %     
% % % %     heatmpaOutPut{i} = ndhist([dataStruct{ii}.instSpX{:}], ...
% % % %         [dataStruct{ii}.instSpY{:}],'bins', 4, 'radial','axis',[-200 200 -200 200],'nr','filt');
% % % %     axis([-60 60 -60 60])
% % % %     load('./MyColormaps.mat')
% % % %     set(gcf, 'Colormap', mycmap)
% % % %     axis square
% % % %     line([-60 60],[0 0])
% % % %     line([0 0],[-60 60])
% % % %     shading interp
% % % %     
% % % %     title(sprintf('S%i',ii))
% % % % end
% % % % suptitle('Ocular Drift Velocity');

%% Sanity Check - Velocity Check of MS
% % % % for ii = find(tableSubjectInfo.Stroke == 1)'
% % % %     figure;
% % % %     ax1 = subplot(1,2,1);
% % % %     msAmpAll = [msAllAnalysis.fixation{ii}.msAmplitude{:}];
% % % %     msAngleAll = [msAllAnalysis.fixation{ii}.msAngle{:}];
% % % %     
% % % %     idx = msAmpAll < 30;
% % % %     heatmpaOutPut{i} = polarhistogram(msAngleAll(idx), ...
% % % %         25);
% % % %     %     axis([-10 10 -10 10])
% % % %     %     load('./MyColormaps.mat')
% % % %     %     set(gcf, 'Colormap', mycmap)
% % % %     %     axis square
% % % %     %     line([-10 10],[0 0])
% % % %     %     line([0 0],[-10 10])
% % % %     %     shading interp
% % % %     ax2 = subplot(1,2,2);
% % % %     
% % % %     temp = tableSubjectInfo.vfMap{ii};
% % % %     temp(isnan(temp)) = -20;
% % % %     
% % % %     J = imrotate((temp),0);
% % % %     J(find(J == -20)) = max(max(J));
% % % %     
% % % %     imagesc(J);
% % % %     axis square;
% % % %     set(gca,'XTick',[],'YTick',[])
% % % %     colormap((gray))
% % % %     title(sprintf('S%i',ii))
% % % %     %     colormap(ax1,mycmap)
% % % % end
% % % % suptitle('Microsaccade Direction and BF');
% % % % 
% % % % 
% % % % for ii = find(tableSubjectInfo.Stroke == 0)'
% % % %     figure;
% % % %     %     ax1 = subplot(1,2,1);
% % % %     msAmpAll = [msAllAnalysis.fixation{ii}.msAmplitude{:}];
% % % %     msAngleAll = [msAllAnalysis.fixation{ii}.msAngle{:}];
% % % %     
% % % %     idx = msAmpAll < 30;
% % % %     heatmpaOutPut{i} = polarhistogram(msAngleAll(idx), ...
% % % %         25);
% % % %     %     axis([-10 10 -10 10])
% % % %     %     load('./MyColormaps.mat')
% % % %     %     set(gcf, 'Colormap', mycmap)
% % % %     %     axis square
% % % %     %     line([-10 10],[0 0])
% % % %     %     line([0 0],[-10 10])
% % % %     %     shading interp
% % % %     %     ax2 = subplot(1,2,2);
% % % %     %
% % % %     %     temp = tableSubjectInfo.vfMap{ii};
% % % %     %     temp(isnan(temp)) = -20;
% % % %     %
% % % %     %     J = imrotate((temp),0);
% % % %     %     J(find(J == -20)) = max(max(J));
% % % %     %
% % % %     %     imagesc(J);
% % % %     %     axis square;
% % % %     %     set(gca,'XTick',[],'YTick',[])
% % % %     %     colormap((gray))
% % % %     %     title(sprintf('S%i',ii))
% % % %     %     colormap(ax1,mycmap)
% % % % end
% % % % suptitle('Microsaccade Direction and Size');

%% Sanity Check - for MS and Drift Compensation in Fixation
% Average for each subject
for ii = 1:height(tableSubjectInfo)%(find(tableSubjectInfo.Stroke == 1))' % Patients
    allAmps = [];
    allAmps = msAllAnalysis.fixation{ii}.msAmplitude{:};
    averageAmplitudeMS(ii) = nanmean(allAmps(find(allAmps > 2 & allAmps < 60)));
    
    allAmps = [];
    allAmps = dataStruct{ii}.amplitude;
    averageAmplitudeDrift(ii) = mean(allAmps(find(allAmps > 0)));
    
end
figure;
subplot(1,2,1)
histogram(averageAmplitudeMS(find(tableSubjectInfo.Stroke == 1)),10,'Normalization','Probability');
hold on
histogram(averageAmplitudeDrift(find(tableSubjectInfo.Stroke == 1)),3,'Normalization','Probability');
xlim([0 60])
ylim([0 .7])
subtitle('Patients');
xlabel('Amplitude (arcmin)')
axis square

subplot(1,2,2)
histogram(averageAmplitudeMS(find(tableSubjectInfo.Stroke == 0)),10,'Normalization','Probability');
hold on
histogram(averageAmplitudeDrift(find(tableSubjectInfo.Stroke == 0)),3,'Normalization','Probability');
subtitle('Controls');
xlim([0 60])
ylim([0 .7])
axis square
xlabel('Amplitude (arcmin)')
title('Probability of EM Averaged Across Trials');


% Concatenating All Drift and MS Segment amplitudes
averageAmplitudeMS_P = [];
averageAmplitudeDrift_P = [];
averageAmplitudeMS_C = [];
averageAmplitudeDrift_C = [];
for ii = 1:height(tableSubjectInfo)
    allAmps = [];
    allAmps = msAllAnalysis.fixation{ii}.msAmplitude{:};
    
    allAmpsD = [];
    allAmpsD = dataStruct{ii}.amplitude;
    
    
    if tableSubjectInfo.Stroke(ii) == 1
        averageAmplitudeMS_P =[averageAmplitudeMS_P allAmps(find(allAmps > 3 & allAmps < 60))];
        averageAmplitudeDrift_P = [averageAmplitudeDrift_P (allAmpsD(find(allAmpsD > 0)))];
        
    else
        averageAmplitudeMS_C =[averageAmplitudeMS_C allAmps(find(allAmps > 3 & allAmps < 60))];
        averageAmplitudeDrift_C = [averageAmplitudeDrift_C (allAmpsD(find(allAmpsD > 0)))];
    end
    
end

figure;
subplot(1,2,1)
histogram(averageAmplitudeMS_P,10,'Normalization','Probability');
hold on
histogram(averageAmplitudeDrift_P,3,'Normalization','Probability');
xlim([0 60])
ylim([0 1])
subtitle('Patients');
xlabel('Amplitude (arcmin)')
axis square

subplot(1,2,2)
forleg(1) = histogram(averageAmplitudeMS_C,10,'Normalization','Probability');
hold on
forleg(2) = histogram(averageAmplitudeDrift_C,3,'Normalization','Probability');
subtitle('Controls');
xlim([0 60])
ylim([0 1])
axis square

xlabel('Amplitude (arcmin)')
legend(forleg,{'MS','Drift'});
title('Probability of EM For Concatenated Across Trials');

%% Sanity Check - Do MS and Drift Compensation for Individual Trials
for ii = (find(tableSubjectInfo.Stroke == 1))'
    figure('Position',[20 0 1300 900]);
    subplot(2,3,2)
    allAmp = reshape(msAllAnalysis.fixation{ii}.msAmpStruc,1,[]);
    allAng = reshape(msAllAnalysis.fixation{ii}.msAngleStruct,1,[]);
    idx = [];
    idx = find(allAmp > 3 & allAmp < 60 & ~isnan(allAmp));
    polarhistogram(deg2rad(allAng(idx)));
    title(sprintf('MS,%.2f',rad2deg(circ_mean(deg2rad(allAng(idx))'))))
    
    subplot(2,3,3)
    avDirDriftHist = [];
    for i = 1:length(avDirection(ii,:))
        if ~isempty(avDirection{ii,i})
            avDirDriftHist = [avDirDriftHist (deg2rad(avDirection{ii,i}))];
        end
    end
    idx = [];
    idx = ~isnan(avDirDriftHist)
    polarhistogram(avDirDriftHist(idx));
    title(sprintf('Drift,%.2f',rad2deg(circ_mean(avDirDriftHist(idx)'))));
    
    
    subplot(2,3,1)
    temp = tableSubjectInfo.vfMap{ii};
    temp(isnan(temp)) = -20;
    rotateAngle = 0;
    J = imrotate((temp),rotateAngle);
    J(find(J == -20)) = max(max(J));
    ax(1) = imagesc(J);
    axis square;
    title(ii)
    axis off
    
    subplot(2,3,4)
    avDirDriftVelX = [];
    avDirDriftVelY = [];
    for i = 1:length(dataStruct{ii}.instSpX)
        %         if ~isempty(avDirection{ii,i})
        avDirDriftVelX = [avDirDriftVelX dataStruct{ii}.instSpX{i}];
        avDirDriftVelY = [avDirDriftVelY dataStruct{ii}.instSpY{i}];
        %         end
    end
    idx = avDirDriftVelX < 50 & avDirDriftVelY < 50;
    ndhist(avDirDriftVelX(idx), ...
        avDirDriftVelY(idx), ...
        'bins', .75, 'radial','axis',[-70 70 -70 70],'nr','filt');
    shading interp; %interp/flat
    title('Drift Velocity')
    
    subplot(2,3,5)
    heatMapIm = generateHeatMapSimple( ...
        tableSubjectInfo.fixX{ii}, ...
        tableSubjectInfo.fixY{ii}, ...
        'Bins', 30,...
        'StimulusSize', 0,...
        'AxisValue', 40,...
        'Uncrowded', 4,...
        'Borders', 0);
    hold on
    line([0 0],[-40 40],'LineStyle','--','Color','k','LineWidth',3);
    line([-40 40],[0 0],'LineStyle','--','Color','k','LineWidth',3);
    axis square
    xticks('auto');yticks('auto');
    
    
    meanX = []; meanY = [];
    subplot(2,3,6)
    for i = 1:length(fixationInfo{ii}.tracesX)
        meanX = [meanX nanmean(fixationInfo{ii}.tracesX{i}(1:10))];
        meanY = [meanY nanmean(fixationInfo{ii}.tracesY{i}(1:10))];
    end
    idx = meanX < 60 & meanX > -60 & meanY < 60 & meanY > -60;
    errorbar(mean(meanX(idx)),mean(meanY(idx)),std(meanX(idx)),...
        std(meanX(idx)), std(meanY(idx)), std(meanY(idx)),'o','MarkerSize',10,...
        'MarkerEdgeColor','red','MarkerFaceColor','red','Color','r');
    line([0 0],[-40 40],'LineStyle','--','Color','k','LineWidth',1);
    line([-40 40],[0 0],'LineStyle','--','Color','k','LineWidth',1);
    title('Mean 30ms Start Position');
    
    saveas(gcf,sprintf('%iBarchart.png',ii))
end

%% Sanity Check - look at first few MS to see if there is a more clear shift relationship
for ii = (find(tableSubjectInfo.Stroke == 1))'
    figure('Position',[20 0 600 900]);
    subplot(2,1,2)
    firstMS = [];
    firstMSAmpl = [];
    lastMS = [];
    lastMSAmpl = [];
    for i = 1:length(msAllAnalysis.fixation{ii}.msAngle)
        if ~isempty(msAllAnalysis.fixation{ii}.msAngle{i})
            firstMS = [firstMS msAllAnalysis.fixation{ii}.msAngle{i}(1)];
            firstMSAmpl = [firstMSAmpl msAllAnalysis.fixation{ii}.msAmplitude{i}(1)];
            if length(msAllAnalysis.fixation{ii}.msAngle{i}) > 1
                firstMS = [firstMS msAllAnalysis.fixation{ii}.msAngle{i}(2)];
                firstMSAmpl = [firstMSAmpl msAllAnalysis.fixation{ii}.msAmplitude{i}(2)];
            end
            if length(msAllAnalysis.fixation{ii}.msAngle{i}) > 3
                lastMS = [lastMS msAllAnalysis.fixation{ii}.msAngle{i}(end)];
                lastMSAmpl = [lastMSAmpl msAllAnalysis.fixation{ii}.msAmplitude{i}(end)];
            end
            
        end
    end
    allAmp = firstMS;
    allAng = firstMSAmpl;
    %     allAmp = lastMS;
    %     allAng = lastMSAmpl;
    allAmp(allAmp == 0) = NaN;% firstMS;
    allAng (allAng == 0) = NaN;%firstMSAmpl;
    idx = [];
    idx = find(allAmp > 3 & allAmp < 60 & ~isnan(allAmp));
    polarhistogram((allAng(idx)));
    title(sprintf('MS,%.2f',rad2deg(circ_mean((allAng(idx))'))))
    
    subplot(2,1,1)
    temp = tableSubjectInfo.vfMap{ii};
    temp(isnan(temp)) = -20;
    rotateAngle = 0;
    J = imrotate((temp),rotateAngle);
    J(find(J == -20)) = max(max(J));
    ax(1) = imagesc(J);
    axis square;
    title(ii)
    axis off
    %     suptitle('Last MS')
    suptitle('First MS')
    %     saveas(gcf,sprintf('%iLastMS.png',ii))
    saveas(gcf,sprintf('%iFirstMS.png',ii))
    
end
%% Sanity Check - Other tests to see ms and drift relationship

for ii = 1%(find(tableSubjectInfo.Stroke == 1))'
    figure;
    for i = 1:9%length(msAllAnalysis.fixation{ii}.position)
        subplot(3,3,i)
        x = msAllAnalysis.fixation{ii}.position(i).x;
        y = msAllAnalysis.fixation{ii}.position(i).y;
        idxAxis = (x(1:end-1) < 120 & x(1:end-1) > -120 & ...
            y(1:end-1) < 120 & y(1:end-1) > -120);
        
        idx_D = find(diff(x) < 3 & diff(y) < 3 & ...
            x(1:end-1) < 120 & x(1:end-1) > -120 & ...
            y(1:end-1) < 120 & y(1:end-1) > -120);
        %         idxAdd = (1:end-1);
        angleQ_D = quiver(x(idx_D(1:end-1)),y(idx_D(1:end-1)),...
            diff(x(idx_D)),diff(y(idx_D)),0);
        hold on
        idx_MS = find(diff(x) >= 5 & diff(y) >= 5 & ...
            x(1:end-1) < 120 & x(1:end-1) > -120 & ...
            y(1:end-1) < 120 & y(1:end-1) > -120);
        angleQ_MS = quiver(x(idx_MS(1:end-1)),y(idx_MS(1:end-1)),...
            diff(x(idx_MS)),diff(y(idx_MS)),0);
        rD = atan2(angleQ_D.VData,angleQ_D.UData);
        rMS = atan2(angleQ_MS.VData,angleQ_MS.UData);
        avDirection_D = (circ_mean(rD')*180/pi);
        avDirection_MS = (circ_mean(rMS')*180/pi);
        axis([-60 60 -60 60])
        line([0,0],[-60 60],'Color','k');
        line([-60,60],[0,0],'Color','k');
        plot(mean(x(idxAxis)),mean(y(idxAxis)),'*','Color','g');
        title(sprintf('D = %.1f, MS = %.1f',avDirection_D,avDirection_MS));
    end
end

%% Figure 5A
figure('Position',[2100 0 1200 1200]);
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 1))' %Patients
    if ii == 3 %% this subject didnt do the task
        continue;
    end
    subplot(4,4,counter)
    heatMapIm = generateHeatMapSimple( ...
        tableSubjectInfo.taskX{ii}, ...
        tableSubjectInfo.taskY{ii}, ...
        'Bins', 10,...
        'StimulusSize', 0,...
        'AxisValue', 20,...
        'Uncrowded', 4,...
        'Borders', 0);
    hold on
    line([0 0],[-40 40],'LineStyle','--','Color','k','LineWidth',3);
    line([-40 40],[0 0],'LineStyle','--','Color','k','LineWidth',3);
    axis square
    title(ii)
    counter = counter + 1;
end

figure('Position',[2100 0 1200 1200]);
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 0))' %Controls
    subplot(4,4,counter)
    heatMapIm = generateHeatMapSimple( ...
        tableSubjectInfo.taskX{ii}, ...
        tableSubjectInfo.taskY{ii}, ...
        'Bins', 10,...
        'StimulusSize', 0,...
        'AxisValue', 20,...
        'Uncrowded', 4,...
        'Borders', 0);
    hold on
    line([0 0],[-40 40],'LineStyle','--','Color','k','LineWidth',3);
    line([-40 40],[0 0],'LineStyle','--','Color','k','LineWidth',3);
    axis square
    title(ii)
    counter = counter + 1;
end

%% Figure 5B - BCEA for Task

idx = find(tableSubjectInfo.Acuity < 60);

figure;
boxplot(tableSubjectInfo.bceaTask,...
    tableSubjectInfo.Stroke','PlotStyle','compact','Labels',{'Control','Patient'});

set(gca, 'YScale', 'log')
ylim([.02 1])
yticks([.03 .1 .3 1])
xticks([1 2])
% xticklabels({'Control','Patient'});
idx2 = (tableSubjectInfo.Acuity < 60);
ylabel('BCEA (deg^2)')
[h,p,~,tt] = ttest2(tableSubjectInfo.bceaTask(tableSubjectInfo.Stroke == 1& idx2),...
    tableSubjectInfo.bceaTask(tableSubjectInfo.Stroke == 0& idx2));
title(sprintf('p = %.2f',p));
%% Figure 5B - Acuity for Task

idx = find(tableSubjectInfo.Acuity < 60);

figure;
boxplot(tableSubjectInfo.Acuity(idx),...
    tableSubjectInfo.Stroke(idx)','PlotStyle','compact','Labels',{'Control','Patient'});

set(gca, 'YScale', 'log')
% ylim([.05 10])
% yticks([.3 1 2 10])
xticks([1 2])
% xticklabels({'Control','Patient'});
ylabel('Acuity (Snellen)')
idx2 = (tableSubjectInfo.Acuity < 60);

[h,p,~,t] = ttest2(tableSubjectInfo.Acuity(tableSubjectInfo.Stroke == 1 & idx2),...
    tableSubjectInfo.Acuity(tableSubjectInfo.Stroke == 0 & idx2));
title(sprintf('p = %.2f',p));

%% Figure 6A&B

[pY_Task, meanValsCLT, meanValsPTT, temp] = ...
    histogramNormalizedForRotation(1:26, ~tableSubjectInfo.Stroke, ...
    tableSubjectInfo.allRotatedTask, ...
    tableSubjectInfo.allRotatedTask, 2, 1); %x = 1 or y = 2
figure;
errorbar([1 2],[meanValsCLT.mean meanValsCLT.mean],[meanValsCLT.sem meanValsCLT.sem],...
    'o');
xlim([.1 3])
ylim([-5 5])
% title('Y');
% ylabel('500ms Task')
title('');
ylabel('Arcmin Toward Blind Field')
xticks([1 2])
xticklabels({'Control','Patient'});
x1 = [2.5 2.5];
y1 = [0 4];
hold on
drawArrow(x1,y1,'linewidth',2,'color','k');
% legend(forlegs,{'5 s','500 ms'},'Location','southeast');
text(2.4,1,'Blind Field','Rotation',90);

%%
FolderName = 'Figures';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = string(iFig);
    saveas(FigHandle, fullfile(FolderName, sprintf('%s.epsc',FigName)));
end

FolderName = 'Figures';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = string(iFig);
    saveas(FigHandle, fullfile(FolderName, sprintf('%s.png',FigName)));
end



%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% functions

function [p, meanValsCL, meanValsPT, meanVals] = ...
    histogramNormalizedForRotation(subjectsAll, control, ...
    rotatedValsPT, rotatedValsControl, coordVal, task)

figure;
hold on
for ii = 1:length(subjectsAll)
    if ii == 3 && task == 1
        meanVals(ii) = NaN;
        continue;
    end
    if find(control(ii))
        allHistOut{ii} = histogram(rotatedValsControl{ii}(:,coordVal)','BinLimits',[-60 60],...
            'BinEdges', [-60:0.5:60]);
        %             meanVals(ii) = allControl{ii};
    else
        allHistOut{ii} = histogram(rotatedValsPT{ii}(:,coordVal)','BinLimits',[-60 60],...
            'BinEdges', [-60:0.5:60]);
        %             meanVals(ii) = allRotated{ii}(:,2)';
    end
    meanVals(ii) = mean(allHistOut{ii}.Data);
    temp = find(allHistOut{ii}.Values == max(allHistOut{ii}.Values));
    if length(temp) > 1
        maxBin(ii) = temp(1);
    else
        maxBin(ii) = temp;
    end
    valBin(ii) = allHistOut{ii}.BinEdges(maxBin(ii));
end

[h,p] = ttest2(meanVals(control == 1), meanVals(control == 0));

%%plot meaned new histogram
for ii = 1:length(subjectsAll)
    if ii == 3 && task == 1
        meanBinNorm(ii,:) = NaN;
        continue;
    end
    for i = 1:length(allHistOut{1}.BinEdges)-1
        meanBin(ii,i) = (allHistOut{ii}.Values(i));
    end
    meanBinNorm(ii,:) = normalizeVector(meanBin(ii,:));
end
%     close figure 20

figure; %normalizes
if task == 1
    figsHist(1) = plot(allHistOut{1}.BinEdges(1:end-1), ...
        normalizeVector(mean(meanBinNorm(control == 1,:))),...
        'r');
    hold on
    figsHist(2) =plot(allHistOut{1}.BinEdges(1:end-1), ...
        normalizeVector(nanmean(meanBinNorm(control == 0,:))),...
        'b');
else
    figsHist(1) = plot(allHistOut{1}.BinEdges(1:end-1), ...
        mean(meanBinNorm(control == 1,:)),...
        'r');
    hold on
    figsHist(2) =plot(allHistOut{1}.BinEdges(1:end-1), ...
        mean(meanBinNorm(control == 0,:)),...
        'b');
end
line([mean(meanVals(control == 1)) mean(meanVals(control == 1))],...
    [0 1],'Color','r');
line([nanmean(meanVals(control == 0)) nanmean(meanVals(control == 0))],...
    [0 1],'Color','b');
legend(figsHist,{'Control','Patient'})
ylabel('Normalized Bin Means');
if coordVal == 1
    xlabel('X Gaze Position Rotated');
else
    xlabel('Y Gaze Position Rotated');
end

%     xlim([-45 45])
title(sprintf(' p = %.3f',p));

meanValsCL.mean = nanmean(meanVals(control == 1));
meanValsCL.std = nanstd(meanVals(control == 1));
meanValsCL.sem = sem(meanVals(control == 1));
meanValsPT.mean = nanmean(meanVals(control == 0));
meanValsPT.std = nanstd(meanVals(control == 0));
meanValsPT.sem = sem(meanVals(control == 0));
end

function [result,limit] = generateHeatMapSimple( xValues, yValues, varargin )
%Creates 2D Distribution Map of Traces
n_bins = 40;
axisValue = 40;
stimuliSize = 1;
offset = 0;
doubleTarget = 0;
condition = 0;
borders = 1;
rotateIm = 0;

k = 1;
Properties = varargin;
while k <= length(Properties) && ischar(Properties{k})
    switch (Properties{k})
        case 'Bins'
            n_bins =  Properties{k + 1};
            Properties(k:k+1) = [];
        case 'StimulusSize'
            stimuliSize = Properties{k + 1};
            Properties(k:k+1) = [];
        case 'AxisValue'
            axisValue = Properties{k + 1};
            Properties(k:k+1) = [];
        case 'Offset'
            offset = Properties{k + 1};
            Properties(k:k+1) = [];
        case 'DoubleTargets'
            doubleTarget = Properties{k + 1};
            Properties(k:k+1) = [];
        case 'Uncrowded' %(should be 1 for U, 2 for Crowded, 4 = Fixation)
            condition = Properties{k + 1};
            Properties(k:k+1) = [];
        case 'Borders'
            borders = Properties{k + 1};
            Properties(k:k+1) = [];
        case 'Rotate'
            rotateIm = Properties{k + 1};
            Properties(k:k+1) = [];
        otherwise
            k = k + 1;
    end
end

idx = find(xValues > -axisValue & ...
    xValues < axisValue &...
    yValues > -axisValue & ...
    yValues < axisValue);

xValues = xValues(idx);
yValues = yValues(idx);

limit.xmin = floor(min(xValues));
limit.xmax = ceil(max(xValues));
limit.ymin = floor(min(yValues));
limit.ymax = ceil(max(yValues));

result = MyHistogram2(xValues, yValues, [limit.xmin,limit.xmax,n_bins;limit.ymin,limit.ymax,n_bins]);
result = result./(max(max(result)));

if rotateIm ~= 0
    result = imrotate((result),rotateIm);
end

load('./MyColormaps.mat');
mycmap(1,:) = [1 1 1];
set(gcf, 'Colormap', mycmap)

hold on
temp = pcolor(linspace(limit.xmin, limit.xmax, size(result, 1)),...
    linspace(limit.ymin, limit.ymax, size(result, 1)),...
    result');

%width in arcminutes
if stimuliSize == 0
    if condition == 0
    else
        centerX = 8;
        centerY = -8;
        width = 16;
        height = 16;
        rectangle('Position',[-centerX+stimuliSize, centerY, width, height],'LineWidth',3,'LineStyle','-')
    end
else
    stimuliSize = stimuliSize/2;
    width = 2 * stimuliSize;
    height = width * 5;
    centerX = (-stimuliSize+offset);
    centerY = (-stimuliSize*5);
    %     rectangle('Position',[centerX, centerY, width, height],'LineWidth',2)
    
    if doubleTarget
        % if uEcc(numEcc)> 0
        rectangle('Position',[-centerX+stimuliSize, centerY, width, height],'LineWidth',2,'LineStyle','--')
        % end
    end
    
    %     spacing = 1.4;
    %     arcminEcc = uEcc * params.pixelAngle;
    if condition == 2
        
        rectangle('Position',[-(width + (width * 1.4)) + offset, centerY, width, height],'LineWidth',1) %Right
        
        rectangle('Position',[(width * 1.4) + offset, centerY, width, height], 'LineWidth',1) %Left
        
        rectangle('Position',[centerX, -(height + (height * 1.4)), width, height], 'LineWidth',1) % Bottom
        
        rectangle('Position',[centerX, (height * 1.4), width, height], 'LineWidth',1) %Top
        
    end
    if condition == 1 || condition == 2
        rectangle('Position',[centerX, centerY, width, height],'LineWidth',3)
    end
    if condition == 4
        p = plot(0,0,'--ks','MarkerSize',stimuliSize);
        p(1).LineWidth = 3;
    end
end
% p(1).LineWidth = 3;

set(gca, 'FontSize', 12)

if borders == 0
    set(gca,'xtick',[], 'ytick', []);
end

caxis([.1 ceil(max(max(result)))])
shading interp; %interp/flat

axis([-axisValue axisValue -axisValue axisValue]);


end
function plotexamplemap(ii,tableSubjectInfo,goodSamples)

figure;
subplot(5,2,1)
temp = tableSubjectInfo.vfMap{ii};
temp(isnan(temp)) = -20;
rotateAngle = 0
J = imrotate((temp),rotateAngle);
J(find(J == -20)) = max(max(J));
imagesc(J);
axis square;
set(gca,'XTick',[],'YTick',[])
ylabel('Degrees')
xlabel('Degrees')
yticks([1 420])
xticks([1 540])
xticklabels({'-30','30'})
yticklabels({'-30','30'})
title(sprintf('P%i',ii));

subplot(5,2,2)

heatMapIm = generateHeatMapSimple( ...
    tableSubjectInfo.fixX{ii}, ...
    tableSubjectInfo.fixY{ii}, ...
    'Bins', 30,...
    'StimulusSize', 0,...
    'AxisValue', 40,...
    'Uncrowded', 4,...
    'Borders', 0);
hold on
line([0 0],[-40 40],'LineStyle','--','Color','k','LineWidth',1);
line([-40 40],[0 0],'LineStyle','--','Color','k','LineWidth',1);
axis square

% [pks] = findpeaks(tableSubjectInfo.fixX{ii});
% msStarts = find(pks > 20 | pks < -20 & pks < 60 & pks > -60);
% [pks2] = ischange(msStarts,'linear');
% trialParts = msStarts((pks2));
% trialParts = round(length(tableSubjectInfo.fixX{ii})/2)...
%     :1000:length(tableSubjectInfo.fixX{ii});
counter = 1;
for i = 3:2:3+6
    subplot(5,2,[i i+1])
    % figure;
    x = tableSubjectInfo.fixX{ii}(goodSamples(counter):goodSamples(counter+1));
    y = tableSubjectInfo.fixY{ii}(goodSamples(counter):goodSamples(counter+1));
    
    plot(1:length(x),x,'-','LineWidth',3)
    hold on
    plot(1:length(y),y,'-')
    
    ylim([-20 20])
    xlim([1 5000])
    %     xticks([1:100:1000])
    xlabel('Samples (341hz)')
    counter = counter + 2;
    % xticklabels(mat2str([1:100*3.41:1000*3.41]))E
end
% colorbar
end



