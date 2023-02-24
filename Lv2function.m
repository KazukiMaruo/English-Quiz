function level2=Lv2function(win)

screensize = [0 0 800 600];
backgroundcolor = [0 0 0];
screenRect=screensize

%all file downloading
SoundfileList=["ant.wav","axe.wav","banana.wav","bat.wav","belt.wav","brush.wav","canary.wav", "cape.wav","cat.wav","cherry.wav","dog.wav","dress.wav","duck.wav","eagle.wav","fox.wav","goat.wav","goose.wav","hat.wav","jacket.wav","kiwi.wav","koala.wav","ladder.wav","lemon.wav","lion.wav","mole.wav","peach.wav","pencil.wav","penguin.wav","pig.wav","pumpkin.wav","rabbit.wav","sheep.wav","shirt.wav","skunk.wav","swan.wav","tiger.wav","tomato.wav","zebra.wav"]
revisedsoundfilelist={'ant.wav','axe.wav','banana.wav','bat.wav','belt.wav','brush.wav','canary.wav', 'cape.wav','cat.wav','cherry.wav','dog.wav','dress.wav','duck.wav','eagle.wav','fox.wav','goat.wav','goose.wav','hat.wav','jacket.wav','kiwi.wav','koala.wav','ladder.wav','lemon.wav','lion.wav','mole.wav','peach.wav','pencil.wav','penguin.wav','pig.wav','pumpkin.wav','rabbit.wav','sheep.wav','shirt.wav','skunk.wav','swan.wav','tiger.wav','tomato.wav','zebra.wav'};
picturefileList=["ant.jpg","axe.jpg","banana.jpg","bat.jpg","belt.jpg","brush.jpg","canary.jpg", "cape.jpg","cat.jpg","cherry.jpg","dog.jpg","dress.jpg","duck.jpg","eagle.jpg","fox.jpg","goat.jpg","goose.jpg","hat.jpg","jacket.jpg","kiwi.jpg","koala.jpg","ladder.jpg","lemon.jpg","lion.jpg","mole.jpg","peach.jpg","pencil.jpg","penguin.jpg","pig.jpg","pumpkin.jpg","rabbit.jpg","sheep.jpg","shirt.jpg","skunk.jpg","swan.jpg","tiger.jpg","tomato.jpg","zebra.jpg"]
revisedpicturefilelist={'ant.jpg','axe.jpg','banana.jpg','bat.jpg','belt.jpg','brush.jpg','canary.jpg', 'cape.jpg','cat.jpg','cherry.jpg','dog.jpg','dress.jpg','duck.jpg','eagle.jpg','fox.jpg','goat.jpg','goose.jpg','hat.jpg','jacket.jpg','kiwi.jpg','koala.jpg','ladder.jpg','lemon.jpg','lion.jpg','mole.jpg','peach.jpg','pencil.jpg','penguin.jpg','pig.jpg','pumpkin.jpg','rabbit.jpg','sheep.jpg','shirt.jpg','skunk.jpg','swan.jpg','tiger.jpg','tomato.jpg','zebra.jpg'}

%Open PTB
%Screen('Preference','VisualDebugLevel',0);
%[win screenRect]=Screen('OpenWindow',0,backgroundcolor,screensize);

screenCntrX=screenRect(3)/2;
screenCntrY=screenRect(4)/2;

%write the title
lazy=imread("lazy.png");
general=imread("general.png");
studious=imread("studious.png");

texlazy=Screen('MakeTexture',win, lazy);
texgeneral=Screen('MakeTexture',win, general);
texstudious=Screen('MakeTexture',win, studious);

Screen('DrawTexture', win,texlazy,[],[screenRect]);
Screen('flip',win)
[y,Fs] = audioread("ショット.mp3");
sound(y,Fs)
pause(.5)
Screen('DrawTexture', win,texgeneral,[],[screenRect]);
Screen('flip',win)
sound(y,Fs)
pause(.5)
Screen('DrawTexture', win,texstudious,[],[screenRect]);
Screen('flip',win)
sound(y,Fs)
pause(.5)
onipic=imread("setsubun_oni_kowai.png");
texoni=Screen('MakeTexture',win, onipic);
Screen('DrawTexture', win,texoni,[],[screenRect]);
Screen('flip',win)
[y,Fs] = audioread("爆発2.mp3");
sound(y,Fs)
pause(.3)
Screen('DrawTexture', win,texlazy,[],[screenCntrX screenCntrY-screenCntrY/1.2 screenCntrX+screenCntrX/1.5 screenCntrY-screenCntrY/3]);
Screen('DrawTexture', win,texgeneral,[],[screenCntrX screenCntrY-screenCntrY/4 screenCntrX+screenCntrX/1.5 screenCntrY+screenCntrY/4]);
Screen('DrawTexture', win,texstudious,[],[screenCntrX screenCntrY+screenCntrY/3 screenCntrX+screenCntrX/1.5 screenCntrY+screenCntrY/1.2]);
Screen('DrawTexture', win,texoni,[],[screenCntrX-screenCntrX/1.1 screenCntrY/2 screenCntrX/1.1 screenCntrY+screenCntrY/1.1]);
DrawFormattedText(win, ['Select the course'],screenCntrX/4,screenCntrY-screenCntrY/1.5,[255 255 255],[],[],[],[3]);
        
Screen('flip',win)

%get click
course2=0; %storing tiral times
clickstop2=true
while clickstop2
[x,y,button] = GetMouse(win);
    if x > screenCntrX && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY-screenCntrY/1.2 && y < screenCntrY-screenCntrY/3
        if button(1)
        clickstop2=false;
        course2=5;
        end
    end
    if x > screenCntrX && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY-screenCntrY/4 && y < screenCntrY+screenCntrY/4
        if button(1)
        clickstop2=false;   
        course2=10;
        end
    end    
    if x > screenCntrX && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY+screenCntrY/3 && y < screenCntrY+screenCntrY/1.2
        if button(1)
        clickstop2=false;   
        course2=20;
        end
    end
end


%calculate the start and end time
myStart2=GetSecs;

%2nd Quiz start
trialcount2=0;
correctcount2=0;
earnedtrialcount2=0;
soundstimulationstorage=[]
wrongsoundstimuationstorage2=[]

soundtrial=true
while soundtrial

        %make the sounnd
        Soundstimulation2 = SoundfileList(randperm(length(SoundfileList),1))
        %soundstimulationstorage=[soundstimulationstorage Soundstimulation2]
        SoundfileList(SoundfileList==Soundstimulation2)=[];
        [y,Fs] = audioread(Soundstimulation2)
        sound(y,Fs)

        %index of choosen sound
        idxChoosensound=find(strcmp(char(Soundstimulation2),revisedsoundfilelist));

        %showing choosen pic
        picforsound=imread(picturefileList(idxChoosensound));
        texchoosenpics=Screen('MakeTexture',win, picforsound);
        Screen('DrawTexture', win,texchoosenpics,[],[screenRect]);        
        Screen(win,'Flip');
        pause(1)

        % dictation time
        typedword=[];
        misscounter=0;
        soundtrialinside=true

        while soundtrialinside
        mynapoleon=imread("napoleon.png");
        texnapoleon=Screen('MakeTexture',win, mynapoleon);
        Screen('DrawTexture', win,texnapoleon,[],[screenCntrX/4 screenCntrY/4 screenCntrX/1.5 screenCntrY/1.5]);
        DrawFormattedText(win, ['Type the sound' '\n' '   '   '\n'  '   '],'center','center',[255 255 255],[],[],[],[3]);
        DrawFormattedText(win, '[Sound Button: 1]','center',screenCntrY/3,[255 255 255],[],[],[],[3]);
        picforsound=imread(picturefileList(idxChoosensound));
        texchoosenpics=Screen('MakeTexture',win, picforsound);
        Screen('DrawTexture', win,texchoosenpics,[],[screenCntrX/2 screenCntrY+(screenCntrY/5) screenCntrX+(screenCntrX/2) screenCntrY+(screenCntrY/1.1)]);
        DrawFormattedText(win, typedword, 'center', 'center')
        Screen(win,'flip')
            
        [keyTime keyCode] = KbStrokeWait;
        keypressed=KbName(keyCode);
        writingformatpics=char(picturefileList(idxChoosensound))

            if strcmp(keypressed,'1!')
                [y,Fs] = audioread(Soundstimulation2)    
                sound(y,Fs)
            elseif strcmp(keypressed,'Return')
                %answer check
                if strcmp(typedword,extractBefore(revisedpicturefilelist(idxChoosensound),'.jpg'));
                    DrawFormattedText(win,['Correct!' '\n' 'Press enter to continue'] ,'center','center',[255 255 0],[],[],[],[2]);
                    Screen(win,'Flip');
                    correctcount2=correctcount2+1
                    KbStrokeWait
                    break
                else misscounter=misscounter+1;                 
                    if misscounter==3;
                       DrawFormattedText(win,['Incorrect' '\n' '[Answer: ' extractBefore(writingformatpics,'.jpg') ']' ], 'center' ,screenCntrY/1.3, [255 0 0], [],[],[],[1.5]);
                       DrawFormattedText(win,['Press enter to go next question'], 'center' ,screenCntrY+(screenCntrY/1.1), [255 0 0], [],[],[],[1.5]);
                       Screen('DrawTexture', win,texchoosenpics,[],[screenCntrX/2 screenCntrY screenCntrX+(screenCntrX/2) screenCntrY+(screenCntrY/1.3)]);
                       wrongsoundstimuationstorage2=[wrongsoundstimuationstorage2 Soundstimulation2];
                       soundtrialinside=false
                    end
                    if misscounter==2;
                       DrawFormattedText(win,['Incorrect' '\n' 'Press enter to try more than 1 time'],'center','center',[255 0 0],[],[],[],[2]);
                    end
                    if misscounter==1;
                       DrawFormattedText(win,['Incorrect' '\n' 'Press enter to try more than 2 times'],'center','center',[255 0 0],[],[],[],[2]);
                    end
                 Screen(win,'Flip');
                 KbStrokeWait
                end
    
            elseif strcmp(keypressed,'DELETE')
                typedword=[typedword(1:end-1)]
            else typedword=[typedword keypressed];
            end               
        end %while soundtrialinside

    trialcount2=trialcount2+1
    %result
    if isempty(SoundfileList)
        SoundfileList=["ant.wav","axe.wav","banana.wav","bat.wav","belt.wav","brush.wav","canary.wav", "cape.wav","cat.wav","cherry.wav","dog.wav","dress.wav","duck.wav","eagle.wav","fox.wav","goat.wav","goose.wav","hat.wav","jacket.wav","kiwi.wav","koala.wav","ladder.wav","lemon.wav","lion.wav","mole.wav","peach.wav","pencil.wav","penguin.wav","pig.wav","pumpkin.wav","rabbit.wav","sheep.wav","shirt.wav","skunk.wav","swan.wav","tiger.wav","tomato.wav","zebra.wav"]
    end
    if trialcount2==course2;
           earnedtrialcount2=earnedtrialcount2+trialcount2
           myStop2=GetSecs;
           avarage2 = correctcount2/trialcount2*100 %avarage 
           howlong2=round([myStop2-myStart2],1)
           background=imread("backgroundcertificate.jpg");
           texbackground=Screen('MakeTexture',win, background);
           Screen('DrawTexture', win,texbackground,[],[screenRect]);
           mymoney=imread("money.png");
           texmymoney=Screen('MakeTexture',win, mymoney);
           Screen('DrawTexture', win,texmymoney,[],[screenCntrX/5 screenCntrY/5 screenCntrX/1.5 screenCntrY/1.5]);
           DrawFormattedText(win,['You learned ' num2str(trialcount2) ' words in this lesson'],'center',[screenCntrY/1.3],[0 0 0],[],[],[],[2])
           DrawFormattedText(win,['Total money ['  num2str(earnedtrialcount2) '$]'],'center',[screenCntrY/2],[0 0 0],[],[],[],[2])
           DrawFormattedText(win,['Earned  Commited  Good' '\n' ' [' num2str(trialcount2) '$]         [' num2str(howlong2) 's]         [' num2str(avarage2) '%]'],'center','center',[0 0 0],[],[],[],[1])
           DrawFormattedText(win,['Menu [1]' '\n' 'Quit [2]' '\n' 'Try Again [Enter]'],'center',[screenCntrY*1.3],[0 0 0],[],[],[],[1])
           pause(.5)
           Screen(win,'Flip');

           %To cotinue or quit the lesson.
           [keyTime keyCode] = KbStrokeWait;
           keyName=KbName(keyCode); 
           if keyName(1)=='2'
              DrawFormattedText(win,['Great Job!' '\n' 'You progressed!'],'center','center',[255 255 255],[],[],[],[1])
              Screen(win,'Flip');
              pause(2)
              Screen('close',win)
	          break
            % cotinue 
            elseif keyName(1)=='1';
                break
                soundtrial=false
           else soundtrial=true
               trialcount2=0;
               myStart2=GetSecs;
               correctcount2=0;
          
           end
    end
end

%background
menuback=imread("menuback.png");
texback=Screen('MakeTexture',win,menuback );
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
Reviewbutton2=imread("Review2.png");
texReview2=Screen('MakeTexture',win,Reviewbutton2);
Screen('DrawTexture', win,texReview2,[],[screenCntrX/3.5+screenCntrX screenCntrY+screenCntrY/1.9 screenCntrX/1.5+screenCntrX screenCntrY+screenCntrY/1.3]);




Screen(win,'Flip');

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
    %Review
    if x > screenCntrX/3.5+screenCntrX && x < screenCntrX/1.5+screenCntrX && y > screenCntrY+screenCntrY/1.9 && y < screenCntrY+screenCntrY/1.3
        if button(1)

                %calculate the start and end time
                myStart2=GetSecs;
                
                %2nd Quiz start
                trialcount2=0;
                correctcount2=0;
                earnedtrialcount2=0;
                finishcount2=length(wrongsoundstimuationstorage2);
                SoundfileList=[wrongsoundstimuationstorage2]
                
                soundtrial=true
                while soundtrial
                
                        %make the sounnd
                        Soundstimulation2 = SoundfileList(randperm(length(SoundfileList),1))
                        %soundstimulationstorage=[soundstimulationstorage Soundstimulation2]
                        SoundfileList(SoundfileList==Soundstimulation2)=[];
                        [y,Fs] = audioread(Soundstimulation2)
                        sound(y,Fs)
                
                        %index of choosen sound
                        idxChoosensound=find(strcmp(char(Soundstimulation2),revisedsoundfilelist));
                
                        %showing choosen pic
                        picforsound=imread(picturefileList(idxChoosensound));
                        texchoosenpics=Screen('MakeTexture',win, picforsound);
                        Screen('DrawTexture', win,texchoosenpics,[],[screenRect]);        
                        Screen(win,'Flip');
                        pause(1)
                
                        % dictation time
                        typedword=[];
                        misscounter=0;
                        soundtrialinside=true
                
                        while soundtrialinside
                        mynapoleon=imread("napoleon.png");
                        texnapoleon=Screen('MakeTexture',win, mynapoleon);
                        Screen('DrawTexture', win,texnapoleon,[],[screenCntrX/4 screenCntrY/4 screenCntrX/1.5 screenCntrY/1.5]);
                        DrawFormattedText(win, ['Type the sound' '\n' '   '   '\n'  '   '],'center','center',[255 255 255],[],[],[],[3]);
                        DrawFormattedText(win, '[Sound Button: 1]','center',screenCntrY/3,[255 255 255],[],[],[],[3]);
                        picforsound=imread(picturefileList(idxChoosensound));
                        texchoosenpics=Screen('MakeTexture',win, picforsound);
                        Screen('DrawTexture', win,texchoosenpics,[],[screenCntrX/2 screenCntrY+(screenCntrY/5) screenCntrX+(screenCntrX/2) screenCntrY+(screenCntrY/1.1)]);
                        DrawFormattedText(win, typedword, 'center', 'center')
                        Screen(win,'flip')
                            
                        [keyTime keyCode] = KbStrokeWait;
                        keypressed=KbName(keyCode);
                        writingformatpics=char(picturefileList(idxChoosensound))
                
                            if strcmp(keypressed,'1!')
                                [y,Fs] = audioread(Soundstimulation2)    
                                sound(y,Fs)
                            elseif strcmp(keypressed,'Return')
                                %answer check
                                if strcmp(typedword,extractBefore(revisedpicturefilelist(idxChoosensound),'.jpg'));
                                    DrawFormattedText(win,['Correct!' '\n' 'Press enter to continue'] ,'center','center',[255 255 0],[],[],[],[2]);
                                    Screen(win,'Flip');
                                    correctcount2=correctcount2+1
                                    KbStrokeWait
                                    break
                                else misscounter=misscounter+1;                 
                                    if misscounter==3;
                                       DrawFormattedText(win,['Incorrect' '\n' '[Answer: ' extractBefore(writingformatpics,'.jpg') ']' ], 'center' ,screenCntrY/1.3, [255 0 0], [],[],[],[1.5]);
                                       DrawFormattedText(win,['Press enter to go next question'], 'center' ,screenCntrY+(screenCntrY/1.1), [255 0 0], [],[],[],[1.5]);
                                       Screen('DrawTexture', win,texchoosenpics,[],[screenCntrX/2 screenCntrY screenCntrX+(screenCntrX/2) screenCntrY+(screenCntrY/1.3)]);
                                       wrongsoundstimuationstorage2=[wrongsoundstimuationstorage2 Soundstimulation2];
                                       soundtrialinside=false
                                    end
                                    if misscounter==2;
                                       DrawFormattedText(win,['Incorrect' '\n' 'Press enter to try more than 1 time'],'center','center',[255 0 0],[],[],[],[2]);
                                    end
                                    if misscounter==1;
                                       DrawFormattedText(win,['Incorrect' '\n' 'Press enter to try more than 2 times'],'center','center',[255 0 0],[],[],[],[2]);
                                    end
                                 Screen(win,'Flip');
                                 KbStrokeWait
                                end
                    
                            elseif strcmp(keypressed,'DELETE')
                                typedword=[typedword(1:end-1)]
                            else typedword=[typedword keypressed];
                            end               
                        end %while soundtrialinside
                
                    trialcount2=trialcount2+1
                    %result
                    if trialcount2==finishcount2;
                           earnedtrialcount2=earnedtrialcount2+trialcount2
                           myStop2=GetSecs;
                           avarage2 = correctcount2/trialcount2*100 %avarage 
                           howlong2=round([myStop2-myStart2],1)
                           background=imread("backgroundcertificate.jpg");
                           texbackground=Screen('MakeTexture',win, background);
                           Screen('DrawTexture', win,texbackground,[],[screenRect]);
                           mymoney=imread("money.png");
                           texmymoney=Screen('MakeTexture',win, mymoney);
                           Screen('DrawTexture', win,texmymoney,[],[screenCntrX/5 screenCntrY/5 screenCntrX/1.5 screenCntrY/1.5]);
                           DrawFormattedText(win,['You learned ' num2str(trialcount2) ' words in this lesson'],'center',[screenCntrY/1.3],[0 0 0],[],[],[],[2])
                           DrawFormattedText(win,['Total money ['  num2str(earnedtrialcount2) '$]'],'center',[screenCntrY/2],[0 0 0],[],[],[],[2])
                           DrawFormattedText(win,['Earned  Commited  Good' '\n' ' [' num2str(trialcount2) '$]         [' num2str(howlong2) 's]         [' num2str(avarage2) '%]'],'center','center',[0 0 0],[],[],[],[1])
                           DrawFormattedText(win,['Menu [1]' '\n' 'Quit [2]' '\n' 'Try Again [Enter]'],'center',[screenCntrY*1.3],[0 0 0],[],[],[],[1])
                           pause(.5)
                           Screen(win,'Flip');
                
                           %To cotinue or quit the lesson.
                           [keyTime keyCode] = KbStrokeWait;
                           keyName=KbName(keyCode); 
                           if keyName(1)=='2'
                              DrawFormattedText(win,['Great Job!' '\n' 'You progressed!'],'center','center',[255 255 255],[],[],[],[1])
                              Screen(win,'Flip');
                              pause(2)
                              Screen('close',win)
	                          break
                            % cotinue 
                            elseif keyName(1)=='1';
                                break
                                soundtrial=false
                           else soundtrial=true
                               trialcount2=0;
                               myStart2=GetSecs;
                               correctcount2=0;
                          
                           end
                    end
                end
                
                %background
                menuback=imread("menuback.png");
                texback=Screen('MakeTexture',win,menuback );
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

 
        end
    end


end
