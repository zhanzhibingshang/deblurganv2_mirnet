clear all;clc;
addpath('/home/zengwh/deblurring_by_realistic_blurring/function')

%result_image_path = '/home2/zengwh/deblur/MIRNet/result/MIRNet16';
result_image_path = '/home2/zengwh/deblur/defocus-deblurring-dual-pixel/DPDNet/results/res_l5_s512_f0.7_d0.4_dd_dp_source';
real_shape_path = '/home2/zengwh/deblur/defocus-deblurring-dual-pixel/datasets/source/train/shape';
all_dir = dir(real_shape_path);

count = 0
sumpsnr =  0;
sumERGAS = 0;
sumRMSE = 0;
sumSAM = 0;
sumSSIM = 0;
        
for i =3:length(all_dir)
    dir_name = all_dir(i).name;
    per_dir = dir([real_shape_path,'/',dir_name]);
    for j = 3:length(per_dir)
        %output = imread([result_image_path,'/',dir_name,'/',per_dir(j).name]);
        output = imread([result_image_path,'/',dir_name,'/',per_dir(j).name(1:end-4), '_p.png']);
                
        gt = imread([real_shape_path,dir_name,'/sharp/',per_dir(j).name]);
        
        %[psnr,rmse, ergas, sam, uiqi,ssim] = quality_assessment(double(im2uint8(gt)), double(im2uint8(((output)))), 0, 1);
        [psnr,rmse, ergas, sam, uiqi,ssim] = quality_assessment(double(gt), double(output), 0, 1);
        
        sumpsnr = sumpsnr + psnr;
        sumERGAS = sumERGAS + ergas;
        sumRMSE = sumRMSE + rmse;
        sumSAM = sumSAM + sam;
        sumSSIM = sumSSIM + ssim;
        count = count + 1
    end
end

averageSSIM = sumSSIM/count

averageERGAS = sumERGAS/count

averagePSNR = sumpsnr/count

averageRMSE = sumRMSE/count

averageSAM = sumSAM/count



e = abs(double(gt)/255-double(output)/255);
figure
imshow(e)
colormap jet
caxis([0 0.0001])

% e = abs(double(B)/255-double(output_final_0));
% figure
% imshow(e)
% colormap jet
% caxis([0 0.1])
