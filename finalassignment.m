%% With Lv.1 function and Lv2function
%constant
%if you want to change the screensize, please change the size in Lv1 function.m and Lv2 function.m as well.
screensize = [0 0 800 600];
backgroundcolor = [0 0 0];

%Open PTB
Screen('Preference','VisualDebugLevel',0);
[win screenRect]=Screen('OpenWindow',0,backgroundcolor,screensize);

screenCntrX=screenRect(3)/2;
screenCntrY=screenRect(4)/2;

%background
menuback=imread("menuback.png");

texback=Screen('MakeTexture',win,menuback);
Screen('DrawTexture', win,texback,[],[screenRect]);
%title
menu=imread("menu.png");
texmenu=Screen('MakeTexture',win,menu );
Screen('DrawTexture', win,texmenu,[],[screenCntrX/2.2 screenCntrY/15 screenCntrX+screenCntrX/2.2 screenCntrY/2.5]);
DrawFormattedText(win,[' ' '\n' 'Click the course'],'center',screenCntrY/2,[0 0 0],[],[],[],[1]);
%exitbutton
exitbutton=imread("exit.png");
texexit=Screen('MakeTexture',win,exitbutton );
Screen('DrawTexture', win,texexit,[],[screenCntrX+screenCntrX/2.2 screenCntrY+screenCntrY/1.3 screenCntrX+screenCntrX/1.1 screenCntrY+screenCntrY/1.01]);
%Lv.1 and Lv.2
Lv1button=imread("Lv.1.png");
texlv1=Screen('MakeTexture',win,Lv1button);
Screen('DrawTexture', win,texlv1,[],[screenCntrX/3.5 screenCntrY screenCntrX/1.5 screenCntrY+(screenCntrY/2)]);
Lv2button=imread("Lv.2.png");
texlv2=Screen('MakeTexture',win,Lv2button);
Screen('DrawTexture', win,texlv2,[],[screenCntrX+screenCntrX/3.5 screenCntrY screenCntrX+screenCntrX/1.5 screenCntrY+screenCntrY/2]);

Screen(win,'Flip');

%Get click
while true
[x,y,button] = GetMouse(win);
    if x > screenCntrX+screenCntrX/2.2 && x < screenCntrX+screenCntrX/1.1 && y > screenCntrY+screenCntrY/1.3 && y < screenCntrY+screenCntrY/1.01
     
          if button(1)
              Screen('CloseAll')
           end
    end
    %Lv.1
    if x > screenCntrX/3.5 && x < screenCntrX/1.5 && y > screenCntrY && y < screenCntrY+screenCntrY/2
        if button(1)       
           level1=Lv1function(win);
        end
    end
    %Lv.2
    if x > screenCntrX+screenCntrX/3.5 && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY && y < screenCntrY+screenCntrY/2
        if button(1)
           level2=Lv2function(win);
        end
    end

end