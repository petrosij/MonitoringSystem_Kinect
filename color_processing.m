%применение цифровых фильтров
img1=rgb2gray(img);
% figure , imshow(img1);
img2=medfilt2(img1, [20 20]);
% figure , imshow(img2);
img3 = im2bw(img2);
% figure , imshow(img3);
img4 = edge(img3,'sobel');
% figure, imshow(img4);

%нахождение границы обьекта 
img5 = imfill(img4,'holes');
 figure, imshow(img5);

% dim = size(img5);
% col = fix(dim(2)/2);
% row = min(find(img5(:,col))) 
% boundary = bwtraceboundary(img5,[row, col],'N');
% figure
% imshow(img)
% hold on;
% plot(boundary(:,2),boundary(:,1),'g','LineWidth',3)


depthimage=img5;
[yp,xp]=size(depthimage);
yp2=fix(yp/2);
xp2=fix(xp/2);
depthimage2=depthimage;


% direction to the left, then first to up, second down;
% initial values
M=zeros(11,11);
M2=zeros(11,11);

for i = -5:5
    for j = -5:5
        M(6+i,6+j)=depthimage(yp2+i,xp2+j);
    end
end


for i = -5:5
    for j = -5:5
        M2(6+i,6+j)=depthimage(yp2+i,xp2+j-1); %mooving square
    end
end
sim=1; % количество едениц
unsim=0; % количество нулей

%begining of movment to the left

while sim>unsim
    sim=0;
    unsim=0;
    xp2=xp2-1;
    image11=drawred(image11,yp3,xp3);
        for i = -5:5
            for j = -5:5
                M2(6+i,6+j)=depthimage(yp2+i,xp2+j); % mooving square
            end
        end
        
        for i = -5:5
             for j = -5:5
                    if M2(i+6,j+6) == 1 % comparing every pixel with 1
                         sim = sim+1;
                    else
                         unsim = unsim+1;
                    end
             end
        end
        yp3=yp2;
        xp3=xp2;
        yp4=yp2;
        xp4=xp2;
        
end

%проверка границы
%         for i = -5:5
%             for j = -5:5
%                 depthimage(yp2+i,xp2+j) = 255; % mooving square
%             end
%         end


% mooving up

% making M3 (right square)
M3 = zeros(11,11);
for i = -5:5
     for j = -5:5
          M3(6+i,6+j)=depthimage(yp2+i,xp2+j+5);
     end
end

% for now sim and unsim are for right square
% sim_l and unsim_l are for left square
sim=1;
unsim=0;
sim_l=0;
unsim_l=0;
%begining of mooving
while sim>unsim
    sim=0;
    unsim=0;
    yp3=yp3-1;
    image11=drawred(image11,yp3,xp3);
        for i = -5:5
            for j = -5:5
                M3(6+i,6+j)=depthimage(yp3+i,xp3+j+5); %right mooving square
            end
        end
        
        for i = -5:5
             for j = -5:5
                    if M3(i+6,j+6)==0 % comparing every pixel with 0
                         unsim = unsim+1;
                    else
                         sim = sim+1;
                    end
             end
        end
        
      if sim>unsim            %чтобы не уходил на право кубик после нахождения верхней границы ???
        %первое сравнение поле первого подьема для того чтобы не было unsim_l=sim_l=0
        sim_l=0;
        unsim_l=0;
                for i = -5:5
                    for j = -5:5
                        M2(6+i,6+j)=depthimage(yp3+i,xp3+j); %left mooving square
                    end
                end
                
                for i = -5:5
                    for j = -5:5
                       if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                           unsim_l = unsim_l+1;
                       else
                           sim_l = sim_l+1;
                       end
                    end
                end
        
        while (abs(sim_l-unsim_l))/min(sim_l,unsim_l)*(100)  >  20
            
            if unsim_l>sim_l
                xp3=xp3+1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp3+i,xp3+j); %left mooving square
                         end
                     end
            else
                xp3=xp3-1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp3+i,xp3+j); %left mooving square
                         end
                     end
            end
            
            sim_l=0;
            unsim_l=0;
                    for i = -5:5
                        for j = -5:5
                           if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                               unsim_l = unsim_l+1;
                           else
                               sim_l = sim_l+1;
                           end
                        end
                    end
        end
      end  
end

%moving down
%initial values
M3 = zeros(11,11);
M2 = zeros(11,11);
for i = -5:5
     for j = -5:5
          M3(6+i,6+j)=depthimage(yp4+i,xp4+j+5); %right mooving square
     end
end
for i = -5:5
     for j = -5:5
          M2(6+i,6+j)=depthimage(yp4+i,xp4+j); %left mooving square
     end
end
% for now sim and unsim are for right square
% sim_l and unsim_l are for left square
sim=1;
unsim=0;
sim_l=0;
unsim_l=0;
%begining of mooving
while sim>unsim

    sim=0;
    unsim=0;
    yp4=yp4+1;
    image11=drawred(image11,yp4,xp4);
        for i = -5:5
            for j = -5:5
                M3(6+i,6+j)=depthimage(yp4+i,xp4+j+5); %right mooving square
            end
        end
        
        for i = -5:5
             for j = -5:5
                    if M3(i+6,j+6) == 0 % comparing every pixel with avarage value
                         unsim = unsim+1;
                    else
                         sim = sim+1;
                    end
             end
        end
        
      if sim>unsim            %чтобы не уходил на право кубик после нахождения верхней границы
        %первое сравнение поле первого подьема для того чтобы не было unsim_l=sim_l=0
        sim_l=0;
        unsim_l=0;
                for i = -5:5
                    for j = -5:5
                        M2(6+i,6+j)=depthimage(yp4+i,xp4+j); %left mooving square
                    end
                end
                
                for i = -5:5
                    for j = -5:5
                       if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                           unsim_l = unsim_l+1;
                       else
                           sim_l = sim_l+1;
                       end
                    end
                end
        
        while (abs(sim_l-unsim_l))/min(sim_l,unsim_l)*(100)  >  20
            
            if unsim_l>sim_l
                xp4=xp4+1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp4+i,xp4+j); %left mooving square
                         end
                     end
            else
                xp4=xp4-1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp4+i,xp4+j); %left mooving square
                         end
                     end
            end
            
            sim_l=0;
            unsim_l=0;
                    for i = -5:5
                        for j = -5:5
                           if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                               unsim_l = unsim_l+1;
                           else
                               sim_l = sim_l+1;
                           end
                        end
                    end
        end
      end  
end

%восстановление значений середины экрана и задание начальных значений
yp2=fix(yp/2);
xp2=fix(xp/2);
M2=zeros(11,11);
M3=zeros(11,11);
sim=1;
unsim=0;

for i = -5:5
    for j = -5:5
        M(6+i,6+j)=depthimage(yp2+i,xp2+j);
    end
end

for i = -5:5
    for j = -5:5
        M2(6+i,6+j)=depthimage(yp2+i,xp2+j-1); %mooving square
    end
end

%Начало движения вправо

while sim>unsim
    sim=0;
    unsim=0;
    xp2=xp2+1;
    image11=drawred(image11,yp2,xp2);
        for i = -5:5
            for j = -5:5
                M2(6+i,6+j)=depthimage(yp2+i,xp2+j); % mooving square
            end
        end
        
        for i = -5:5
             for j = -5:5
                    if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                         unsim = unsim+1;
                    else
                         sim = sim+1;
                    end
             end
        end
        yp5=yp2;
        xp5=xp2;
        yp6=yp2;
        xp6=xp2;
        
end

% moving up

% making M3 (left square)

for i = -5:5
     for j = -5:5
          M3(6+i,6+j)=depthimage(yp2+i,xp2+j-5);
     end
end

% for now sim and unsim are for left square
% sim_l and unsim_l are for right square
sim=1;
unsim=0;
sim_l=0;
unsim_l=0;

%begining of mooving

%moving up
while sim>unsim
    sim=0;
    unsim=0;
    yp5=yp5-1;
    image11=drawred(image11,yp5,xp5);
        for i = -5:5
            for j = -5:5
                M3(6+i,6+j)=depthimage(yp5+i,xp5+j-5); %left mooving square
            end
        end
        
        for i = -5:5
             for j = -5:5
                    if M3(i+6,j+6) == 0 % comparing every pixel with avarage value
                         unsim = unsim+1;
                    else
                         sim = sim+1;
                    end
             end
        end
        
      if sim>unsim            %чтобы не уходил на право кубик после нахождения верхней границы
        %первое сравнение поле первого подьема для того чтобы не было unsim_l=sim_l=0
        sim_l=0;
        unsim_l=0;
                for i = -5:5
                    for j = -5:5
                        M2(6+i,6+j)=depthimage(yp5+i,xp5+j); %left mooving square
                    end
                end
                
                for i = -5:5
                    for j = -5:5
                       if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                           unsim_l = unsim_l+1;
                       else
                           sim_l = sim_l+1;
                       end
                    end
                end
        
        while (abs(sim_l-unsim_l))/min(sim_l,unsim_l)*(100)  >  20
            
            if unsim_l>sim_l
                xp5=xp5-1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp5+i,xp5+j); %left mooving square
                         end
                     end
            else
                xp5=xp5+1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp5+i,xp5+j); %left mooving square
                         end
                     end
            end
            
            sim_l=0;
            unsim_l=0;
                    for i = -5:5
                        for j = -5:5
                           if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                               unsim_l = unsim_l+1;
                           else
                               sim_l = sim_l+1;
                           end
                        end
                    end
        end
      end  
end

%moving down
%initial values
M3 = zeros(11,11);
M2 = zeros(11,11);
for i = -5:5
     for j = -5:5
          M3(6+i,6+j)=depthimage(yp4+i,xp4+j-5); %left mooving square
     end
end
for i = -5:5
     for j = -5:5
          M2(6+i,6+j)=depthimage(yp4+i,xp4+j); %right mooving square
     end
end
% for now sim and unsim are for left square
% sim_l and unsim_l are for right square
sim=1;
unsim=0;
sim_l=0;
unsim_l=0;

% moving down

while sim>unsim
    sim=0;
    unsim=0;
    yp6=yp6+1;
    image11=drawred(image11,yp6,xp6);
        for i = -5:5
            for j = -5:5
                M3(6+i,6+j)=depthimage(yp6+i,xp6+j-5); %left mooving square
            end
        end
        
        for i = -5:5
             for j = -5:5
                    if M3(i+6,j+6) == 0 % comparing every pixel with avarage value
                         unsim = unsim+1;
                    else
                         sim = sim+1;
                    end
             end
        end
        
      if sim>unsim            %чтобы не уходил на право кубик после нахождения верхней границы
        %первое сравнение поле первого подьема для того чтобы не было unsim_l=sim_l=0
        sim_l=0;
        unsim_l=0;
                for i = -5:5
                    for j = -5:5
                        M2(6+i,6+j)=depthimage(yp6+i,xp6+j); %left mooving square
                    end
                end
                
                for i = -5:5
                    for j = -5:5
                       if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                           unsim_l = unsim_l+1;
                       else
                           sim_l = sim_l+1;
                       end
                    end
                end
        
        while (abs(sim_l-unsim_l))/min(sim_l,unsim_l)*(100)  >  20
            
            if unsim_l>sim_l
                xp6=xp6-1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp6+i,xp6+j); %left mooving square
                         end
                     end
            else
                xp6=xp6+1;
                     for i = -5:5
                         for j = -5:5
                             M2(6+i,6+j)=depthimage(yp6+i,xp6+j); %left mooving square
                         end
                     end
            end
            
            sim_l=0;
            unsim_l=0;
                    for i = -5:5
                        for j = -5:5
                           if M2(i+6,j+6) == 0 % comparing every pixel with avarage value
                               unsim_l = unsim_l+1;
                           else
                               sim_l = sim_l+1;
                           end
                        end
                    end
        end
      end  
end
image11=drawblack(image11,yp3,xp3);
image11=drawblack(image11,yp4,xp4);
image11=drawblack(image11,yp5,xp5);
image11=drawblack(image11,yp6,xp6);
%подстройка выбившейся точки
d1=abs(xp4-xp3);
d2=abs(yp5-yp3);
d3=abs(xp6-xp5);
d4=abs(yp6-yp4);
maxm=[d1,d2,d3,d4];
if max(maxm)>30
    if max(maxm)==d1
        di1=(xp5-xp3)/(yp6-yp5);
        di2=(xp6-xp4)/(yp6-yp5);
        if min(abs(di1-1.5),abs(di2-1.5))==abs(di1-1.5)
            xp4=xp3;
        else
            xp3=xp4;
        end
    end
    if max(maxm)==d2
        di1=(xp6-xp4)/(yp4-yp3);
        di2=(xp6-xp4)/(yp6-yp5);
        if min(abs(di1-1.5),abs(di2-1.5))==abs(di1-1.5)
            yp5=yp3;
        else
            yp3=yp5;
        end
    end
    if max(maxm)==d3
        di1=(xp6-xp4)/(yp4-yp3);
        di2=(xp5-xp3)/(yp4-yp3);
        if min(abs(di1-1.5),abs(di2-1.5))==abs(di1-1.5)
            xp5=xp6;
        else
            xp6=xp5;
        end
    end    
    if max(maxm)==d4
        di1=(xp5-xp3)/(yp6-yp5);
        di2=(xp5-xp3)/(yp4-yp3);
        if min(abs(di1-1.5),abs(di2-1.5))==abs(di1-1.5)
            yp4=yp6;
        else
            yp6=yp4;
        end
    end 
end

%рисовние кубиков как углов монитора

for i = -2:2
    for j = -2:2
        img1(yp3+i,xp3+j)=255;
    end
end
for i = -2:2
    for j = -2:2
        img1(yp4+i,xp4+j)=255;
    end
end
for i = -2:2
    for j = -2:2
        img1(yp5+i,xp5+j)=255;
    end
end
for i = -2:2
    for j = -2:2
        img1(yp6+i,xp6+j)=255;
    end
end

% imshow(img1);

%обрезаем экран
BW=imcrop(img1,[min(xp4,xp3); min(yp5,yp3); max(xp5,xp6)-min(xp4,xp3);max(yp4,yp6)-min(yp5,yp3)]);
[YLN,XLN]=size(BW);

%вырезаем цифру 1 для ЧСС
pulse1img =imcrop(BW,[fix((67*XLN)/515);fix((113*YLN)/407);fix((13*XLN)/515);fix((25*YLN)/407)] );
pulse1imgBW = im2bw(pulse1img);
figure , imshow(pulse1imgBW);

%вырезаем цифру 2 для ЧСС
pulse2img =imcrop(BW,[fix((54*XLN)/515);fix((113*YLN)/407);fix((13*XLN)/515);fix((25*YLN)/407)] );
pulse2imgBW = im2bw(pulse2img);
figure , imshow(pulse2imgBW);

%проверка поля третьей цыфры перфузии
SOV=0;
NSOV=0;
flag_nalichie=1;
perf3img =imcrop(BW,[fix((37*XLN)/469);fix((162*YLN)/374);fix((7*XLN)/471);fix((18*YLN)/374)] );
perf3imgBW = im2bw(perf3img);
figure , imshow(perf3imgBW);
[x,y]=size(perf3imgBW);
for i = 1:x
    for j = 1:y
        if perf3imgBW(i,j) == 1
            SOV=SOV+1;
        end
    end
end
if SOV > 20
    flag_nalichie = 1;
else
    flag_nalichie = 0;
end

if flag_nalichie == 1
%вырезаем цифру 1 для perf
perf1img =imcrop(BW,[fix((61*XLN)/471);fix((160*YLN)/374);fix((12*XLN)/471);fix((18*YLN)/374)] );
perf1imgBW = im2bw(perf1img);
figure , imshow(perf1imgBW);

%вырезаем цифру 2 для perf
perf2img =imcrop(BW,[fix((47*XLN)/471);fix((160*YLN)/374);fix((12*XLN)/471);fix((18*YLN)/374)] );
perf2imgBW = im2bw(perf2img);
figure , imshow(perf2imgBW);

%вырезаем цыфру 3 для perf
perf3img =imcrop(BW,[fix((36*XLN)/469);fix((160*YLN)/374);fix((12*XLN)/471);fix((18*YLN)/374)] );
perf3imgBW = im2bw(perf3img);
figure , imshow(perf3imgBW);
end
if flag_nalichie == 0
%вырезаем цифру 1 для perf
perf1img =imcrop(BW,[fix((60*XLN)/471);fix((159*YLN)/374);fix((13*XLN)/471);fix((21*YLN)/374)] );
perf1imgBW = im2bw(perf1img);
figure , imshow(perf1imgBW);

%вырезаем цифру 2 для perf
perf2img =imcrop(BW,[fix((47*XLN)/471);fix((158*YLN)/374);fix((12*XLN)/471);fix((20*YLN)/374)] );
perf2imgBW = im2bw(perf2img);
figure , imshow(perf2imgBW);
end
    
%сравниваем цыфры
%необходимо предотвратьить ошибку
if x == 0
    flag_error = 1;
else 
    flag_error = 0;
end

if flag_error == 0;
pulse1 = sovpadenie (pulse1imgBW);
pulse2 = sovpadenie (pulse2imgBW);
if flag_nalichie == 1
perf1 = sovpadenie (perf1imgBW);
perf2 = sovpadenie (perf2imgBW);
perf3 = sovpadenie (perf3imgBW);
end
if flag_nalichie == 0
perf1 = sovpadenie (perf1imgBW);
perf2 = sovpadenie (perf2imgBW);
end


%выводим в командную строку результат
pulse1slov='Pressure is %d%d beats per minute';
pulse=sprintf(pulse1slov,pulse1,pulse2); 

if flag_nalichie == 1
perf1slov=' perfusion is %d.%d%d';
perf=sprintf(perf1slov,perf1,perf2,perf3);
end
if flag_nalichie == 0
perf1slov=' perfusion is %d.%d';
perf=sprintf(perf1slov,perf1,perf2);  
end

disp(perf);
disp(pulse);
end

if flag_error == 1
errorslov='failture in detecting of numbers';
error1=sprintf(errorslov); 
disp(error1);
end

figure ,imshow(image11);

function y = sovpadenie (img8_n)
img8_n=imresize(img8_n,[183,100],'nearest');
im0 = imread('im0.png');
im1 = imread('im1.png');
im2 = imread('im2.png');
im3 = imread('im3.png');
im4 = imread('im4.png');
im5 = imread('im5.png');
im6 = imread('im6.png');
im7 = imread('im7.png');
im8 = imread('im8.png');
im9 = imread('im9.png');

i0=imresize(im0,[183,100],'nearest');
ib0=im2bw(i0, 0.8);

i1=imresize(im1,[183,100],'nearest');
ib1=im2bw(i1, 0.8);

i2=imresize(im2,[183,100],'nearest');
ib2=im2bw(i2, 0.8);

i3=imresize(im3,[183,100],'nearest');
ib3=im2bw(i3, 0.8);

i4=imresize(im4,[183,100],'nearest');
ib4=im2bw(i4, 0.8);

i5=imresize(im5,[183,100],'nearest');
ib5=im2bw(i5, 0.8);

i6=imresize(im6,[183,100],'nearest');
ib6=im2bw(i6, 0.8);

i7=imresize(im7,[183,100],'nearest');
ib7=im2bw(i7, 0.8);

i8=imresize(im8,[183,100],'nearest');
ib8=im2bw(i8, 0.8);

i9=imresize(im9,[183,100],'nearest');
ib9=im2bw(i9, 0.8);
sov0=0;

for i=1:183
    for j=1:100
        if img8_n(i,j)==ib0(i,j)==1 sov0=sov0+1;
        end
    end
end

sov1=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib1(i,j)==1 sov1=sov1+1;
        end
    end
end

sov2=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib2(i,j)==1 sov2=sov2+1;
        end
    end
end

sov3=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib3(i,j)==1 sov3=sov3+1;
        end
    end
end

sov4=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib4(i,j)==1 sov4=sov4+1;
        end
    end
end

sov5=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib5(i,j)==1 sov5=sov5+1;
        end
    end
end

sov6=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib6(i,j)==1 sov6=sov6+1;
        end
    end
end

sov7=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib7(i,j)==1 sov7=sov7+1;
        end
    end
end

sov8=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib8(i,j)==1 sov8=sov8+1;
        end
    end
end

sov9=0;
for i=1:183
    for j=1:100
        if img8_n(i,j)==ib9(i,j)==1 sov9=sov9+1;
        end
    end
end
A=[sov0; sov1; sov2 ;sov3 ;sov4; sov5;sov6 ;sov7; sov8; sov9];
if sov0==max(A)
    y=0;
end
if sov1==max(A)
    y=1;
end
if sov2==max(A)
    y=2;
end
if sov3==max(A)
    y=3;
end
if sov4==max(A)
    y=4;
end
if sov5==max(A)
    y=5;
end
if sov6==max(A)
    y=6;
end
if sov7==max(A)
    y=7;
end
if sov8==max(A)
    y=8;
end
if sov9==max(A)
    y=9;
end
end

function img = drawred (img,x,y)

for i=-2:2
    for j = -2:2
        img(i+x,j+y,1)=255;
        img(i+x,j+y,2)=0;
        img(i+x,j+y,3)=0;
    end
end
end

function img = drawblack (img,x,y)

for i=-6:6
    for j = -6:6
        img(i+x,j+y,1)=255;
        img(i+x,j+y,2)=255;
        img(i+x,j+y,3)=255;
    end
end
end
