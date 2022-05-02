
% param
img1 = phonecalc128;
img2 = few128;
img3 = nallo128;
a = 1e-10;

figure(41);
subplot('331');
showgrey(img1);
title('original image');
subplot('332');
showgrey(pow2image(img1, a));
title('phase');
% function pixels = randphaseimage(inpic)
% give phase randomly
subplot('333');
showgrey(randphaseimage(img1));
title('random phase');

subplot('334');
showgrey(img2);
subplot('335');
showgrey(pow2image(img2, a));
% function pixels = randphaseimage(inpic)
% give phase randomly
subplot('336');
showgrey(randphaseimage(img2));

subplot('337');
showgrey(img3);
subplot('338');
showgrey(pow2image(img3, a));
% function pixels = randphaseimage(inpic)
% give phase randomly
subplot('339');
showgrey(randphaseimage(img3));

