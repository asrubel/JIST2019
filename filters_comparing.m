clear
clc
close all
addpath(genpath('src'));

test = [1 3 5 7 13 23 26 34 37 38];
filters = {'DCTF','BM3D','NLM','SAIF','LPGPCA','KSVD','KLLD'};
mods = {'MDCTF','MBM3D'};
metrics = {'PSNR','PSNRHVSM','FSIM','SSIM','MSSSIM'};

%% Moderate spatial correlation level of ASCGN
nsigma = 10;
gsigma = [0.5 0.8 1];

for g = 1:numel(gsigma)
    for n = 1:numel(nsigma)
        for m = 1:numel(metrics)
            figure;
            hold on
            
            T = cell(length(filters)+length(mods)+4,numel(test)+1);
            T{2,1} = 'Noisy AWGN';
            T{3,1} = 'BM3D AWGN';
            T{4,1} = 'Noisy';
            T(5:11,1) = filters;
            T(12:end,1) = mods;
            T(1,2:end) = num2cell(test);
            
            load(['data/pure/' metrics{m} '_awgn_noisy_nsigma_' num2str(nsigma(n)) '.mat'],['n' metrics{m}]);
            eval(['NA = n' metrics{m} ';']);
            load(['data/pure/' metrics{m} '_awgn_BM3D_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
            eval(['FA = f' metrics{m} ' - NA;']);
            NoisyCells = strsplit(sprintf('%.3f ', NA),' ');
            T(2,2:end) = NoisyCells(1:end-1);
            FilterCells = strsplit(sprintf('%.3f ', FA),' ');
            T(3,2:end) = FilterCells(1:end-1); 
            
            load(['data/pure/' metrics{m} '_ascgn_noisy_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['n' metrics{m}]);
            eval(['N = n' metrics{m} ';']);
            NoisyCells = strsplit(sprintf('%.3f ', N),' ');
            T(4,2:end) = NoisyCells(1:end-1);
            
            for f = 1:numel(filters)
                load(['data/pure/' metrics{m} '_ascgn_' filters{f} '_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
                eval(['F = f' metrics{m} ';']);
                plot(F-N,'LineWidth',2);
                FilterCells = strsplit(sprintf('%.3f ', F-N),' ');
                T(4+f,2:end) = FilterCells(1:end-1);
            end            
            
            for a = 1:numel(mods)
                load(['data/pure/' metrics{m} '_ascgn_' mods{a} '_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
                eval(['F = f' metrics{m} ';']);
                plot(F-N,'LineWidth',2,'LineStyle','--');
                FilterCells = strsplit(sprintf('%.3f ', F-N),' ');
                T(11+a,2:end) = FilterCells(1:end-1);
            end
            % XLS-file will be created only for Windows
            % xlswrite(['out/report/ASCN_gsigma_' num2str(gsigma(g)) '_nsigma_' num2str(nsigma(n)) '.xlsx'],T,metrics{m});
            
            title(['ASCGN, \sigma_G = ' num2str(gsigma(g)) ', \sigma_N = ' num2str(nsigma(n))]);
            xlabel('Test image');
            xticklabels(num2cell(test));
            ylabel(['I' metrics{m}]);
            legend([filters mods],'Location','northoutside','Orientation','horizontal');
        end
    end
end

%% Higher spatial correlation level of ASCGN
nsigma = 15;
gsigma = [1.5 2 2.5];

for g = 1:numel(gsigma)
    for n = 1:numel(nsigma)
        for m = 1:numel(metrics)
            figure;
            hold on
            
            T = cell(length(filters)+length(mods)+4,numel(test)+1);
            T{2,1} = 'Noisy AWGN';
            T{3,1} = 'BM3D AWGN';
            T{4,1} = 'Noisy';
            T(5:11,1) = filters;
            T(12:end,1) = mods;
            T(1,2:end) = num2cell(test);
            
            load(['data/pure/' metrics{m} '_awgn_noisy_nsigma_' num2str(nsigma(n)) '.mat'],['n' metrics{m}]);
            eval(['NA = n' metrics{m} ';']);
            load(['data/pure/' metrics{m} '_awgn_BM3D_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
            eval(['FA = f' metrics{m} ' - NA;']);
            NoisyCells = strsplit(sprintf('%.3f ', NA),' ');
            T(2,2:end) = NoisyCells(1:end-1);
            FilterCells = strsplit(sprintf('%.3f ', FA),' ');
            T(3,2:end) = FilterCells(1:end-1); 
            
            load(['data/pure/' metrics{m} '_ascgn_noisy_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['n' metrics{m}]);
            eval(['N = n' metrics{m} ';']);
            NoisyCells = strsplit(sprintf('%.3f ', N),' ');
            T(4,2:end) = NoisyCells(1:end-1);
            
            for f = 1:numel(filters)
                load(['data/pure/' metrics{m} '_ascgn_' filters{f} '_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
                eval(['F = f' metrics{m} ';']);
                plot(F-N,'LineWidth',2);
                FilterCells = strsplit(sprintf('%.3f ', F-N),' ');
                T(4+f,2:end) = FilterCells(1:end-1);
            end
            
            for a = 1:numel(mods)
                load(['data/pure/' metrics{m} '_ascgn_' mods{a} '_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
                eval(['F = f' metrics{m} ';']);
                plot(F-N,'LineWidth',2,'LineStyle','--');
                FilterCells = strsplit(sprintf('%.3f ', F-N),' ');
                T(11+a,2:end) = FilterCells(1:end-1);
            end
            % XLS-file will be created only for Windows
            % xlswrite(['out/report/ASCN_gsigma_' num2str(gsigma(g)) '_nsigma_' num2str(nsigma(n)) '.xlsx'],T,metrics{m});
            
            title(['ASCGN, \sigma_G = ' num2str(gsigma(g)) ', \sigma_N = ' num2str(nsigma(n))]);
            xlabel('Test image');
            xticklabels(num2cell(test));
            ylabel(['I' metrics{m}]);
            legend([filters mods],'Location','northoutside','Orientation','horizontal');
        end
    end
end

%% Total efficiency decreasing due spatial correlation degree increasing
lspecs = {'k','k--','k:'};

for m = 1:length(metrics)
    for i = 1:2
        switch i
            case 1
                nsigma = 10;
                gsigma = [0.5 0.8 1];
                ncase = 'moderate';
            case 2
                nsigma = 15;
                gsigma = [1.5 2 2.5];
                ncase = 'hard';
        end
        figure;
        hold on        

        for g = 1:numel(gsigma)
            for n = 1:numel(nsigma)
                load(['data/pure/' metrics{m} '_ascgn_BM3D_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
                load(['data/pure/' metrics{m} '_ascgn_noisy_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['n' metrics{m}]);
                eval(['I = f' metrics{m} ' - n'  metrics{m} ';']);
                plot(I,lspecs{g},'LineWidth',2);
            end
        end
        xlim([min(I) max(I)])
        legend({['\sigma_G = ' num2str(gsigma(1))],['\sigma_G = ' num2str(gsigma(2))],['\sigma_G = ' num2str(gsigma(3))]},...
            'Location','NorthOutSide','Orientation','Horizontal');
        xlabel('Test image');
        ylabel(['I' metrics{m}]);
        xlim([1 numel(test)]);
    end
end

%% Comparative analysis of standard and modified versions of DCTF and BM3D
filters = {'DCTF','BM3D','MDCTF','MBM3D'};
lspecs = {'k.-','k:','k--','k'};

for m = 1:length(metrics)
    for i = 1:2
        switch i
            case 1
                nsigma = 10;
                gsigma = 0.8;
                ncase = 'moderate';
            case 2
                nsigma = 15;
                gsigma = 1.5;
                ncase = 'hard';
        end
        
        for g = 1:numel(gsigma)
            for n = 1:numel(nsigma)
                load(['data/pure/' metrics{m} '_ascgn_noisy_gsigma_' num2str(gsigma(g))...
                    '_nsigma_' num2str(nsigma(n)) '.mat'],['n' metrics{m}]);
                figure;
                hold on
                for f = 1:length(filters)
                    load(['data/pure/' metrics{m} '_ascgn_' filters{f} '_gsigma_' num2str(gsigma(g))...
                        '_nsigma_' num2str(nsigma(n)) '.mat'],['f' metrics{m}]);
                    eval(['I = f' metrics{m} ' - n' metrics{m} ';']);
                    plot(I,lspecs{f},'LineWidth',1);
                end
                
                xlim([min(I) max(I)])
                legend(filters,'Location','NorthOutSide','Orientation','Horizontal');
                xlabel('Test image');
                ylabel(['I' metrics{m}]);
                xlim([1 numel(test)]);
            end
        end
    end
end

%% Denoising efficiency decreasing for images by gsigma growth
gsigma = 0.5:0.1:3;

for m = 1:length(metrics)
    load(['data/filter/' metrics{m} '_ascgn_noisy.mat']);
    load(['data/filter/' metrics{m} '_ascgn_MDCTF.mat']);
    eval(['F = Gf' metrics{m} ';']);
    eval(['N = Gn' metrics{m} ';']);
        
    figure;
    plot(gsigma,F((13-1)*7+3,:),'LineWidth',1.5);
    hold on
    plot(gsigma,N((13-1)*7+3,:),'LineWidth',1.5);
    hold on
    plot(gsigma,F((3-1)*7+3,:),'LineWidth',1.5);
    hold on
    plot(gsigma,N((3-1)*7+3,:),'LineWidth',1.5);
    legend({'13f','13n','3f','3n'},'Location','Best');
    title(metrics{m});
end

%% Spearman rank correlation coefficients table among all metrics
clc
RF = cell(length(metrics)+1);
RF(2:end,1) = metrics;
RF(1,2:end) = metrics;
RN = RF;
for m1 = 1:length(metrics)
    for m2 = 1:length(metrics)
        eval(['F1 = Gf' metrics{m1} ';']);
        eval(['F2 = Gf' metrics{m2} ';']);
        s = corr(F1(:),F2(:),'Type','Spearman');
        RF{m1+1,m2+1} = s;
        
        eval(['N1 = Gn' metrics{m1} ';']);
        eval(['N2 = Gn' metrics{m2} ';']);
        n = corr(N1(:),N2(:),'Type','Spearman');
        RN{m1+1,m2+1} = n;
    end
end
disp('Filtered images:')
disp(RF);
disp('Noisy images:')
disp(RN);