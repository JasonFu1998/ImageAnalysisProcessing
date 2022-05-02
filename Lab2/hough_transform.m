
%% triangle128
testimage1 = triangle128;
smalltest1 = binsubsample(testimage1);
scale = 4;
gradmagnthreshold = 10;
nrho = 400;
ntheta = 300;
nlines = 3;

figure;
[linepar,acc] = houghedgeline(testimage1, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, 0);
figure;
showgrey(acc);
disp(linepar);

%% houghtest256
testimage2 = houghtest256;
smalltest2 = binsubsample(binsubsample(testimage2));
scale = 4;
gradmagnthreshold = 20;
nrho = 300;
ntheta = 200;
nlines = 8;
figure;
[linepar,acc] = houghedgeline(testimage2, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, 0);
figure;
showgrey(acc);
disp(linepar);

%% few256
testimage3 = few256;
smalltest3 = binsubsample(binsubsample(testimage3));
scale = 4;
gradmagnthreshold = 20;
nrho = 300;
ntheta = 200;
nlines = 20;
figure;
[linepar,acc] = houghedgeline(testimage3, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, 0);
figure;
showgrey(acc);
disp(linepar);

%% phonecalc256
testimage4 = phonecalc256;
smalltest4 = binsubsample(binsubsample(testimage4));
scale = 9;
gradmagnthreshold = 10;
nrho = 500;
ntheta = 400;
nlines = 40;
verbose = 0;

figure;
[linepar,acc] = houghedgeline(testimage4, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, verbose);
figure;
showgrey(acc);
disp(linepar);

%% godthem256
testimage5 = godthem256;
smalltest5 = binsubsample(binsubsample(testimage5));
scale = 16;
gradmagnthreshold = 10;
nrho = 800;
ntheta = 600;
nlines = 40;
verbose = 0;

figure;
[linepar,acc] = houghedgeline(testimage5, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, verbose);
figure;
showgrey(acc);
disp(linepar);

%% try log
%% godthem256
testimage3 = few256;
smalltest3 = binsubsample(binsubsample(testimage3));
scale = 9;
gradmagnthreshold = 20;
nrho = 1500;
ntheta = 500;
nlines = 50;
verbose = 0;

figure;
[linepar,acc] = houghedgeline(testimage3, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, verbose);
figure;
showgrey(acc);
disp(linepar);

verbose = 2;

figure;
[linepar,acc] = houghedgeline(testimage3, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, verbose);
figure;
showgrey(acc);
disp(linepar);

verbose = 3;

figure;
[linepar,acc] = houghedgeline(testimage3, scale, gradmagnthreshold, ...
    nrho, ntheta, nlines, verbose);
figure;
showgrey(acc);
disp(linepar);
