chase1 = imread('C:\Users\anara\Desktop\2020FALL\CS484\hw4\questions\RISHLibrary1.jpg');
chase2 = imread('C:\Users\anara\Desktop\2020FALL\CS484\hw4\questions\RISHLibrary2.jpg');
chase1 = im2single(rgb2gray(chase1));
chase2 = im2single(rgb2gray(chase2));
c1=corner(chase1,1000);
c2=corner(chase2,1000);
subplot(1,2,1); imshow(chase1)
hold on
plot(c1(:,1),c1(:,2),'b*')
subplot(1,2,2); imshow(chase2)
hold on
plot(c2(:,1),c2(:,2),'b*')
