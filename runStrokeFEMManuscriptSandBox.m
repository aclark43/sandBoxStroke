%%% Script for Analyzing Huxlin Data and Creating Manuscript Figures
clear all
close all
temp = load('dataTableStroke.mat');

tableSubjectInfo = struct2table(temp.dataTable); %% Also Table 1
%% Figure 2A - Heatmaps for Fixation
figure;
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 1))' %Patients
    subplot(6,3,counter)
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
    counter = counter + 1;
end

figure;
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 0))' %Controls
    subplot(6,3,counter)
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
    counter = counter + 1;
end
%% Figure 2B - BCEA for Fixation

figure;
boxplot(tableSubjectInfo.bceaFix,...
    tableSubjectInfo.Stroke','PlotStyle','compact');

set(gca, 'YScale', 'log')
ylim([.05 10])
yticks([.3 1 2 10])
xticks([1 2])
xticklabels({'Control','Patient'});

[h,p] = ttest2(tableSubjectInfo.bceaFix(tableSubjectInfo.Stroke == 1),...
    tableSubjectInfo.bceaFix(tableSubjectInfo.Stroke == 0));



%% Figure 3
counter = 1;
figure;
for ii = 1:height(tableSubjectInfo)
    if tableSubjectInfo.Stroke(ii) == 0
        continue;
    end
    rotateAngle = tableSubjectInfo.AngleOfLoss{ii};
    if ii == 1
        rotateAngle = 315;
    elseif ii == 2
        rotateAngle = 50;
    elseif ii == 3
        rotateAngle = 145;
    elseif ii == 4
        rotateAngle = 90;
    elseif ii == 10
        rotateAngle = 90;
    elseif ii == 22
        rotateAngle = 315;
    elseif ii == 23
        rotateAngle = 90;
    end
    
    
    subplot(4,4,counter)
    temp = tableSubjectInfo.vfMap{ii};
    temp(isnan(temp)) = -20;
    
    
    J = imrotate((temp),rotateAngle);
    J(find(J == -20)) = max(max(J));
    
    imagesc(J);
    axis square;
    set(gca,'XTick',[],'YTick',[])
    
    colormap((gray))
    if ii == 1
        ylabel('Degrees')
        xlabel('Degrees')
        yticks([1 420])
        xticks([1 540])
        xticklabels({'-30','30'})
        yticklabels({'-30','30'})
    else
        yticks([1 420])
        xticks([1 540])
        xticklabels({'',''})
        yticklabels({'',''})
    end
    
    title(sprintf('P%i',ii));
    
    counter = counter + 1;
    
end

counter = 1;
figure;
for ii = 1:height(tableSubjectInfo)
    if tableSubjectInfo.Stroke(ii) == 0
        continue;
    end
    rotateAngle = tableSubjectInfo.AngleOfLoss{ii};
    if ii == 1
        rotateAngle = 315;
    elseif ii == 2
        rotateAngle = 50;
    elseif ii == 3
        rotateAngle = 145;
    elseif ii == 4
        rotateAngle = 90;
    elseif ii == 10
        rotateAngle = 90;
    elseif ii == 22
        rotateAngle = 315;
    elseif ii == 23
        rotateAngle = 90;
    end
    
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
    generateHeatMapSimple( ...
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
    
end


%% Figure 4A
figure;
subplot(1,2,1)
patientsAllX = [];
patientsAllY = [];

for ii = find(tableSubjectInfo.Stroke == 1)'
    rotateAngle = tableSubjectInfo.AngleOfLoss{ii};
    if ii == 1
        rotateAngle = 315;
    elseif ii == 2
        rotateAngle = 50;
    elseif ii == 3
        rotateAngle = 145;
    elseif ii == 4
        rotateAngle = 90;
    elseif ii == 10
        rotateAngle = 90;
    elseif ii == 22
        rotateAngle = 315;
    elseif ii == 23
        rotateAngle = 90;
    end
%     rotateAngle = 0;
    
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
    
    set(gca,'XTick',[],'YTick',[],'xlabel',[],'ylabel',[])
    %         title(sprintf('%s',subjectsAll{ii}));
    
end
title('Patients')
ellipseXY(patientsAllX, patientsAllY, 65, 'm' ,0)
plot(mean(patientsAllX),mean(patientsAllY),'d','Color','m')

subplot(1,2,2)
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
    
    set(gca,'XTick',[],'YTick',[],'xlabel',[],'ylabel',[])
    %         title(sprintf('%s',subjectsAll{ii}));
    
end
title('Controls')
ellipseXY(patientsAllX, patientsAllY, 65, 'm' ,0)
plot(mean(patientsAllX),mean(patientsAllY),'d','Color','m')

%% Figure3B and C

[pY_FullFixation, meanValsCL, meanValsPT, meansValsIndY] = ...
    histogramNormalizedForRotation(1:26, ~tableSubjectInfo.Stroke, ...
    tableSubjectInfo.allRotated,...
    tableSubjectInfo.allRotated, 2, 0); %x = 1 or y = 2

[pY_500Fixation, meanValsCL500Y, meanValsPT500Y, meansValsInd500Y] = ...
    histogramNormalizedForRotation(1:26, ~tableSubjectInfo.Stroke, ...
    tableSubjectInfo.allRotated500,...
    tableSubjectInfo.allRotated500, 2, 0); %x = 1 or y = 2


figure;
subplot(3,2,1)
    errorbar([0 1],[meanValsCL.mean meanValsPT.mean],[meanValsCL.sem meanValsPT.sem],...
        'o');
    xlim([-.2 1.2])
    ylim([-5 5])
    title('Y')
    ylabel('Full Fixation')
subplot(3,2,3)
    errorbar([0 1],[meanValsCL500Y.mean meanValsPT500Y.mean],[meanValsCL500Y.sem meanValsPT500Y.sem],...
        'o');
    xlim([-.2 1.2])
    ylim([-5 5])
    title('Y');
    ylabel('500ms Fixation')

%% Figure 4 MS Fixation
load('msAllAnalysis.mat')    
load('rotatedAligned.mat');
    
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

[h,p] = ttest(mean([P(:,1:11)']), mean([P(:,13:23)'])); %divide in half

[h,p] = ttest(mean([P(:,5:9)']), mean([P(:,17:21)'])); %look at up and down +- 30deg

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
    
%% Figure 4 Drift Fixation
load('huxlinDriftFixation.mat')
subNum = height(tableSubjectInfo);
majorAxis = 0:15:330;

figure;
subplot(1,3,1)
counter = 1;
values = [];
for ii = find(control)
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
values = [];

for ii = find(~control)
    %     if ii == 3
    %         continue;
    %     end
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
values = [];
subtitle('PT No Rotated');

subplot(1,3,3)
counter = 1;
for ii = find(~control)
    allDriftAngleRot = [];
    rotateAngle = vfResults.patientInfo.(huxID{ii}).middleAngleLoss;
    if ii == 1
        rotateAngle = 315;
    elseif ii == 2
        rotateAngle = 50;
    elseif ii == 3
        rotateAngle = 145;
    elseif ii == 4
        rotateAngle = 90;
    elseif ii == 10
        rotateAngle = 90;
    elseif ii == 22
        rotateAngle = 315;
    elseif ii == 23
        rotateAngle = 90;
    end
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

[h,p] = ttest(mean([P(:,1:11)']), mean([P(:,13:23)'])); %divide in half

[h,p] = ttest(mean([P(:,5:9)']), mean([P(:,17:21)'])); %look at up and down +- 30deg

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
title('Probability of Drift Direction');

%% Velocity Check of Drift
for ii = find(tableSubjectInfo.Stroke)'
    figure;
        ax1 = subplot(1,2,1);
    heatmpaOutPut{i} = ndhist([dataStruct{ii}.instSpX{:}], ...
        [dataStruct{ii}.instSpY{:}],'bins', 2, 'radial','axis',[-200 200 -200 200],'nr','filt');
    axis([-60 60 -60 60])
    load('./MyColormaps.mat')
    set(gcf, 'Colormap', mycmap)
    axis square
    line([-60 60],[0 0])
    line([0 0],[-60 60])
    shading interp

    ax2 = subplot(1,2,2);

    temp = tableSubjectInfo.vfMap{ii};
    temp(isnan(temp)) = -20;
    
    J = imrotate((temp),0);
    J(find(J == -20)) = max(max(J));
    
    imagesc(J);
    axis square;
    set(gca,'XTick',[],'YTick',[])
    colormap((gray))
    title(sprintf('S%i',ii))    
    colormap(ax1,mycmap)
end

for ii = find(~tableSubjectInfo.Stroke)'
    figure;
%     ax1 = subplot(10,2,counter)
%         ax1 = subplot(1,2,1);

    heatmpaOutPut{i} = ndhist([dataStruct{ii}.instSpX{:}], ...
        [dataStruct{ii}.instSpY{:}],'bins', 4, 'radial','axis',[-200 200 -200 200],'nr','filt');
    axis([-60 60 -60 60])
    load('./MyColormaps.mat')
    set(gcf, 'Colormap', mycmap)
    axis square
    line([-60 60],[0 0])
    line([0 0],[-60 60])
    shading interp

    title(sprintf('S%i',ii))    
end
suptitle('Ocular Drift Velocity');

%% %% Velocity Check of MS
for ii = find(tableSubjectInfo.Stroke == 1)'
    figure;
    ax1 = subplot(1,2,1);
    msAmpAll = [msAllAnalysis.fixation{ii}.msAmplitude{:}];
    msAngleAll = [msAllAnalysis.fixation{ii}.msAngle{:}];
    
    idx = msAmpAll < 30;
    heatmpaOutPut{i} = polarhistogram(msAngleAll(idx), ...
        25);
%     axis([-10 10 -10 10])
%     load('./MyColormaps.mat')
%     set(gcf, 'Colormap', mycmap)
%     axis square
%     line([-10 10],[0 0])
%     line([0 0],[-10 10])
%     shading interp
    ax2 = subplot(1,2,2);

    temp = tableSubjectInfo.vfMap{ii};
    temp(isnan(temp)) = -20;
    
    J = imrotate((temp),0);
    J(find(J == -20)) = max(max(J));
    
    imagesc(J);
    axis square;
    set(gca,'XTick',[],'YTick',[])
    colormap((gray))
    title(sprintf('S%i',ii))    
%     colormap(ax1,mycmap)
end
suptitle('Microsaccade Direction and BF');


for ii = find(tableSubjectInfo.Stroke == 0)'
    figure;
%     ax1 = subplot(1,2,1);
    msAmpAll = [msAllAnalysis.fixation{ii}.msAmplitude{:}];
    msAngleAll = [msAllAnalysis.fixation{ii}.msAngle{:}];
    
    idx = msAmpAll < 30;
    heatmpaOutPut{i} = polarhistogram(msAngleAll(idx), ...
        25);
%     axis([-10 10 -10 10])
%     load('./MyColormaps.mat')
%     set(gcf, 'Colormap', mycmap)
%     axis square
%     line([-10 10],[0 0])
%     line([0 0],[-10 10])
%     shading interp
%     ax2 = subplot(1,2,2);
% 
%     temp = tableSubjectInfo.vfMap{ii};
%     temp(isnan(temp)) = -20;
%     
%     J = imrotate((temp),0);
%     J(find(J == -20)) = max(max(J));
%     
%     imagesc(J);
%     axis square;
%     set(gca,'XTick',[],'YTick',[])
%     colormap((gray))
%     title(sprintf('S%i',ii))    
%     colormap(ax1,mycmap)
end
suptitle('Microsaccade Direction and Size');

%% Check for MS and Drift Compensation in Fixation
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

%% Do MS and Drift Compensation for Individual Trials
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
figure;
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 1))' %Patients
    if ii == 3 %% this subject didnt do the task
        continue;
    end
    subplot(6,3,counter)
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
    counter = counter + 1;
end

figure;
counter = 1;
for ii = (find(tableSubjectInfo.Stroke == 0))' %Controls
    subplot(6,3,counter)
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
    counter = counter + 1;
end

%% Figure 5B - BCEA for Task

idx = find(tableSubjectInfo.Acuity < 60);

figure;
boxplot(tableSubjectInfo.bceaTask,...
    tableSubjectInfo.Stroke','PlotStyle','compact');

set(gca, 'YScale', 'log')
ylim([.02 1])
yticks([.03 .1 .3 1])
xticks([1 2])
xticklabels({'Control','Patient'});
idx2 = (tableSubjectInfo.Acuity < 60);

[h,p] = ttest2(tableSubjectInfo.bceaTask(tableSubjectInfo.Stroke == 1& idx2),...
    tableSubjectInfo.bceaTask(tableSubjectInfo.Stroke == 0& idx2));

%% Figure 5B - Acuity for Task

idx = find(tableSubjectInfo.Acuity < 60);

figure;
boxplot(tableSubjectInfo.Acuity(idx),...
    tableSubjectInfo.Stroke(idx)','PlotStyle','compact');

set(gca, 'YScale', 'log')
% ylim([.05 10])
% yticks([.3 1 2 10])
xticks([1 2])
xticklabels({'Control','Patient'});

idx2 = (tableSubjectInfo.Acuity < 60);

[h,p] = ttest2(tableSubjectInfo.Acuity(tableSubjectInfo.Stroke == 1 & idx2),...
    tableSubjectInfo.Acuity(tableSubjectInfo.Stroke == 0 & idx2));

%% Figure 6A&B

[pY_Task, meanValsCLT, meanValsPTT, temp] = ...
    histogramNormalizedForRotation(1:26, ~tableSubjectInfo.Stroke, ...
    tableSubjectInfo.allRotatedTask, ...
    tableSubjectInfo.allRotatedTask, 2, 1); %x = 1 or y = 2
figure;
 errorbar([0 1],[meanValsCLT.mean meanValsCLT.mean],[meanValsCLT.sem meanValsCLT.sem],...
        'o');
    xlim([-.2 1.2])
    ylim([-5 5])
    title('Y');
    ylabel('500ms Task')
    
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


