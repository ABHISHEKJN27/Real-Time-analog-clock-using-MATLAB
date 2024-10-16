clc,clf,close,clear all;
setfigureproperties;
global CloseReq cc;
hh1=[ ];hm1=[ ];hs1=[ ];
global rs;rs=10;
CloseReq=false;
while 3 
    %time=fix(clock);
    time=datetime('now');
    time2=time+hours(5);
    subplot(1,2,1),hold on
    update_clock1(time);
    hold off
    subplot(1,2,2),hold on
    update_clock2(time2);
    hold off
    %drawnow;
    pause(1);
    if CloseReq
        delete(cc);
        clear all;
        break;
    end
end

function update_clock1(time)
global hh1 hm1 hs1 rs;
thsec = 90+fix(time.Second)*6;
thmin = 90+(time.Minute*6) + (time.Second/10);
thhour = 90+(time.Hour*30) + (time.Minute/2); %thsec-thetasec
delete(hh1);     hh1  = plot([0.1*rs*cosd(thhour) -0.75*rs*cosd(thhour)],...
                                              [-0.1*rs*sind(thhour) 0.75*rs*sind(thhour)],'r','LineWidth',1.75);
delete(hm1);    hm1 = plot([0 -0.9*rs*cosd(thmin)],[0 0.9*rs*sind(thmin)],'k','LineWidth',1.5);
delete(hs1);     hs1  = plot([0 -rs*cosd(thsec)],[0 rs*sind(thsec)],'Color',[1 0 0],'LineWidth',1);
end

function update_clock2(time)
    global hh2 hm2 hs2 rs;
    thsec = 90+fix(time.Second)*6;
    thmin = 90+(time.Minute*6) + (time.Second/10);
    thhour = 90+(time.Hour*30) + (time.Minute/2); %thsec-thetasec
    delete(hh2);     hh2  = plot([0.1*rs*cosd(thhour) -0.75*rs*cosd(thhour)],...
                                                  [-0.1*rs*sind(thhour) 0.75*rs*sind(thhour)],'r','LineWidth',1.75);
    delete(hm2);    hm2 = plot([0 -0.9*rs*cosd(thmin)],[0 0.9*rs*sind(thmin)],'k','LineWidth',1.5);
    delete(hs2);     hs2  = plot([0 -rs*cosd(thsec)],[0 rs*sind(thsec)],'Color',[1 0 0],'LineWidth',1);
end

function setfigureproperties
global cc;
cc=figure('units','pixels',...
            'menubar','none',...
            'position',[500 200 600 600],...
            'name','clockplot',...
            'numbertitle','off',...
            'renderer','opengl',...
            'visible','on',...
            'color',[1 1 1],...
            'CloseRequestFcn', @stl_CloseReqFcn);
    subplot(1,2,1),draw_clock;title('Present time','FontSize',15);
    subplot(1,2,2),draw_clock;title('Manipulated time','FontSize',15);
end

function draw_clock

axis off,hold on
drawcircle(1,12)
for n=1:12
    text(-8.5*cosd(90+(n)*360/12),8.5*sind(90+(n)*360/12),num2str(n))
    plot([0.95*10*cosd(90+(n)*360/12) 1.1*10*cosd(90+(n)*360/12)],...
        [0.95*10*sind(90+(n)*360/12) 1.1*10*sind(90+(n)*360/12)],...
        'k','LineWidth',2)
    for ns=1:5
        plot([1.0*10*cosd(90+(n)*360/12+6*ns) 1.1*10*cosd(90+(n)*360/12+6*ns)],...
            [1.0*10*sind(90+(n)*360/12+6*ns) 1.1*10*sind(90+(n)*360/12+6*ns)],...
            'k','LineWidth',1)
    end
end
axis([-14 14 -15 15]);
end

function drawcircle(varargin)

th=0:6:360;
for n=1:nargin
    if varargin{n}==max(varargin{:})
        plot(varargin{n}*cosd(th),varargin{n}*sind(th),'LineWidth',6);
         plot((varargin{n}+0.8)*cosd(th),(varargin{n}+0.8)*sind(th),'r','LineWidth',6);
    elseif varargin{n}==min(varargin{:})
        fill(varargin{n}*cosd(th),varargin{n}*sind(th),'b')
    else
        plot(varargin{n}*cosd(th),varargin{n}*sind(th),'k')
    end
end
%  incr=45; plot(1.1*max(varargin{:})*cosd(0:incr:360),1.1*max(varargin{:})*sind(0:incr:360),'LineWidth',6)
end

function stl_CloseReqFcn(hObject, eventdata, handles)
    global CloseReq;
        CloseReq = true;
    end