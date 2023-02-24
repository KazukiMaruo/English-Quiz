function level1=Lv1function(win)

%constant
screensize = [0 0 800 600];
backgroundcolor = [0 0 0];
screenRect=screensize

%Open PTB
%Screen('Preference','VisualDebugLevel',0);
%[win screenRect]=Screen('OpenWindow',0,backgroundcolor,screensize);

screenCntrX=screenRect(3)/2;
screenCntrY=screenRect(4)/2;

%screenRect = [0 0 640 480];

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
course=0; %storing the trial count
clickstop=true
while clickstop
[x,y,button] = GetMouse(win);
    if x > screenCntrX && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY-screenCntrY/1.2 && y < screenCntrY-screenCntrY/3
        if button(1)            
        clickstop=false;
        course=5;
        end
    end
    if x > screenCntrX && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY-screenCntrY/4 && y < screenCntrY+screenCntrY/4
        if button(1)
        clickstop=false;   
        course=10;
        end
    end    
    if x > screenCntrX && x < screenCntrX+screenCntrX/1.5 && y > screenCntrY+screenCntrY/3 && y < screenCntrY+screenCntrY/1.2
        if button(1)
        clickstop=false;   
        course=20;
        end
    end
end


%1st Quiz start
earnedtrialcount=0;
trialcount=0;
correctcount=0;
counting=true;
wrongImagestorage=[]

%calculate the start and end time
myStart=GetSecs;

        %images downloading
        picturefileList=["ant.jpg","axe.jpg","banana.jpg","bat.jpg","belt.jpg","brush.jpg","canary.jpg", "cape.jpg","cat.jpg","cherry.jpg","dog.jpg","dress.jpg","duck.jpg","eagle.jpg","fox.jpg","goat.jpg","goose.jpg","hat.jpg","jacket.jpg","kiwi.jpg","koala.jpg","ladder.jpg","lemon.jpg","lion.jpg","mole.jpg","peach.jpg","pencil.jpg","penguin.jpg","pig.jpg","pumpkin.jpg","rabbit.jpg","sheep.jpg","shirt.jpg","skunk.jpg","swan.jpg","tiger.jpg","tomato.jpg","zebra.jpg"];
        originalpicturefileList=["ant.jpg","axe.jpg","banana.jpg","bat.jpg","belt.jpg","brush.jpg","canary.jpg", "cape.jpg","cat.jpg","cherry.jpg","dog.jpg","dress.jpg","duck.jpg","eagle.jpg","fox.jpg","goat.jpg","goose.jpg","hat.jpg","jacket.jpg","kiwi.jpg","koala.jpg","ladder.jpg","lemon.jpg","lion.jpg","mole.jpg","peach.jpg","pencil.jpg","penguin.jpg","pig.jpg","pumpkin.jpg","rabbit.jpg","sheep.jpg","shirt.jpg","skunk.jpg","swan.jpg","tiger.jpg","tomato.jpg","zebra.jpg"];      
        revisedpicturefilelist={'ant.jpg','axe.jpg','banana.jpg','bat.jpg','belt.jpg','brush.jpg','canary.jpg', 'cape.jpg','cat.jpg','cherry.jpg','dog.jpg','dress.jpg','duck.jpg','eagle.jpg','fox.jpg','goat.jpg','goose.jpg','hat.jpg','jacket.jpg','kiwi.jpg','koala.jpg','ladder.jpg','lemon.jpg','lion.jpg','mole.jpg','peach.jpg','pencil.jpg','penguin.jpg','pig.jpg','pumpkin.jpg','rabbit.jpg','sheep.jpg','shirt.jpg','skunk.jpg','swan.jpg','tiger.jpg','tomato.jpg','zebra.jpg'};

while counting
        randpicturefileList=Shuffle(picturefileList);

        %showing michelangelo pics
        mymichelangelo=imread("michelangelo.png");
        texmichelangelo=Screen('MakeTexture',win, mymichelangelo);
        Screen('DrawTexture', win,texmichelangelo,[],[screenCntrX/5 screenCntrY/5 screenCntrX/1.5 screenCntrY/1.5]);
        
        %creating a matrix of 3 pictures
        pictureSize=screenRect(3)/3;
        gridsize=3;
        displaySize=pictureSize*gridsize;
        
        rectCount=0;
        for x=1:pictureSize:displaySize % outer loop %pictureSize=160
             y=screensize(4)/2; % inner loop
	         rectCount = rectCount+1;
               my3pictures(rectCount,:)=[x y x+pictureSize/2 y+pictureSize/2];
            
        end
        %centering
        gridCntr=displaySize/2
        my3pictures(:,[1 3])=my3pictures(:,[1 3])+screenCntrX-gridCntr+pictureSize/4;
        
        
        
        %Show 3 pics to choose
        choosenpictures =[];
        for kk = 1:3
            fileName = randpicturefileList(kk);
            myImage = imread(fileName);
            tex = Screen('MakeTexture',win,myImage)
            Screen('DrawTexture',win,tex,[],[my3pictures(kk,:)]);
            choosenpictures = [choosenpictures fileName];            
        end


        %write the task
        choosenpicturesIDX=randperm(3,1)
        taskworddecided = char(choosenpictures(choosenpicturesIDX))
        strtaskworddecided = convertCharsToStrings(taskworddecided)
        picturefileList(picturefileList==strtaskworddecided) = []
            
        DrawFormattedText(win, ['Choose ' extractBefore(taskworddecided,'.jpg')],'center',screensize(4)/4,[255 255 255],[],[],[],[2]);
        pause(.1)
        Screen(win,'Flip');
        
        %Sound Stimuluation
        SoundfileList=["ant.wav","axe.wav","banana.wav","bat.wav","belt.wav","brush.wav","canary.wav", "cape.wav","cat.wav","cherry.wav","dog.wav","dress.wav","duck.wav","eagle.wav","fox.wav","goat.wav","goose.wav","hat.wav","jacket.wav","kiwi.wav","koala.wav","ladder.wav","lemon.wav","lion.wav","mole.wav","peach.wav","pencil.wav","penguin.wav","pig.wav","pumpkin.wav","rabbit.wav","sheep.wav","shirt.wav","skunk.wav","swan.wav","tiger.wav","tomato.wav","zebra.wav"]
        revisedsoundfilelist={'ant.wav','axe.wav','banana.wav','bat.wav','belt.wav','brush.wav','canary.wav', 'cape.wav','cat.wav','cherry.wav','dog.wav','dress.wav','duck.wav','eagle.wav','fox.wav','goat.wav','goose.wav','hat.wav','jacket.wav','kiwi.wav','koala.wav','ladder.wav','lemon.wav','lion.wav','mole.wav','peach.wav','pencil.wav','penguin.wav','pig.wav','pumpkin.wav','rabbit.wav','sheep.wav','shirt.wav','skunk.wav','swan.wav','tiger.wav','tomato.wav','zebra.wav'};
        idxChoosen=find(strcmp(taskworddecided,revisedpicturefilelist));       
        Soundstimulation=SoundfileList(idxChoosen)
        %make the sound





        [y,Fs] = audioread(Soundstimulation)
        sound(y,Fs)
        
        %Get mouse
        noclick=true
        while noclick 
          [mouseX,mouseY,buttons]=GetMouse(win);
          if buttons(1)
                  if mouseX>my3pictures(choosenpicturesIDX,1) && mouseX<my3pictures(choosenpicturesIDX,3) && mouseY>my3pictures(choosenpicturesIDX,2) && mouseY<my3pictures(choosenpicturesIDX,4);
                      correctcount=correctcount+1
                       while buttons(1)==1;
                           [mouseX,mouseY,buttons]=GetMouse(win); 
                       DrawFormattedText(win,['Correct!' '\n' 'Press enter to continue'] ,'center','center',[255 255 0],[],[],[],[2])
                       Screen(win,'Flip');                                                                 
                       noclick=false
                       end
                  else DrawFormattedText(win,['Incorrect' '\n' 'Press enter to continue' '\n' '[Answer]'],'center',[screenCntrY/2],[255 0 0],[],[],[],[2])
                      wrongImagestorage=[wrongImagestorage choosenpictures(choosenpicturesIDX)]
                       wrongImage = imread(choosenpictures(choosenpicturesIDX));
                       tex = Screen('MakeTexture',win,wrongImage)
                       Screen('DrawTexture',win,tex,[],[screenCntrX/2 screenCntrY screenCntrX+(screenCntrX/2) screenCntrY+(screenCntrY/1.2)]);                    
                       Screen(win,'Flip');
                       noclick=false
                       
                  end

          end
        end
        trialcount=trialcount+1;
        KbStrokeWait

        %result         
        if length(picturefileList)<3;
           picturefileList=["ant.jpg","axe.jpg","banana.jpg","bat.jpg","belt.jpg","brush.jpg","canary.jpg", "cape.jpg","cat.jpg","cherry.jpg","dog.jpg","dress.jpg","duck.jpg","eagle.jpg","fox.jpg","goat.jpg","goose.jpg","hat.jpg","jacket.jpg","kiwi.jpg","koala.jpg","ladder.jpg","lemon.jpg","lion.jpg","mole.jpg","peach.jpg","pencil.jpg","penguin.jpg","pig.jpg","pumpkin.jpg","rabbit.jpg","sheep.jpg","shirt.jpg","skunk.jpg","swan.jpg","tiger.jpg","tomato.jpg","zebra.jpg"]
        end      
        if trialcount==course;
           earnedtrialcount=earnedtrialcount+trialcount
           myStop=GetSecs;
           avarage = correctcount/trialcount*100%avarage 
           howlong=round([myStop-myStart],1)
           background=imread("backgroundcertificate.jpg");
           texbackground=Screen('MakeTexture',win, background);
           Screen('DrawTexture', win,texbackground,[],[screenRect]);
           mymoney=imread("money.png");
           texmymoney=Screen('MakeTexture',win, mymoney);
           Screen('DrawTexture', win,texmymoney,[],[screenCntrX/5 screenCntrY/5 screenCntrX/1.5 screenCntrY/1.5]);
           
           DrawFormattedText(win,['You learned ' num2str(trialcount) ' words in this lesson'],'center',[screenCntrY/1.3],[0 0 0],[],[],[],[2])
           DrawFormattedText(win,['Total money ['  num2str(earnedtrialcount) '$]'],'center',[screenCntrY/2],[0 0 0],[],[],[],[2])
           DrawFormattedText(win,['Earned   Commited  Good' '\n' ' [' num2str(trialcount) '$]       [' num2str(howlong) 's]         [' num2str(avarage) '%]'],'center','center',[0 0 0],[],[],[],[1])
           DrawFormattedText(win,['Menu [1]' '\n' 'Quit [2]' '\n' 'Try Again [Enter]'],'center',[screenCntrY*1.3],[0 0 0],[],[],[],[1])
           Screen(win,'Flip');

           %To next or quit or try again the lesson.
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
                counting=false
           else counting=true
                trialcount=0;
                myStart=GetSecs;
                correctcount=0;               
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
Screen('DrawTexture', win,texexit,[],[screenCntrX+screenCntrX/1.5 screenCntrY+screenCntrY/1.3 screenCntrX+screenCntrX/1.01 screenCntrY+screenCntrY/1.01]);
%Lv.1 and Lv.2
Lv1button=imread("Lv.1.png");
texlv1=Screen('MakeTexture',win,Lv1button);
Screen('DrawTexture', win,texlv1,[],[screenCntrX/3.5 screenCntrY screenCntrX/1.5 screenCntrY+(screenCntrY/2)]);
Lv2button=imread("Lv.2.png");
texlv2=Screen('MakeTexture',win,Lv2button);
Screen('DrawTexture', win,texlv2,[],[screenCntrX+screenCntrX/3.5 screenCntrY screenCntrX+screenCntrX/1.5 screenCntrY+screenCntrY/2]);
Reviewbutton=imread("Review1.png");
texReview=Screen('MakeTexture',win,Reviewbutton);
Screen('DrawTexture', win,texReview,[],[screenCntrX/3.5 screenCntrY+screenCntrY/1.9 screenCntrX/1.5 screenCntrY+screenCntrY/1.3]);



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
    if x > screenCntrX/3.5 && x < screenCntrX/1.5 && y > screenCntrY+screenCntrY/1.9 && y < screenCntrY+screenCntrY/1.3
        if button(1)
           % Review section
           %1st Quiz start
            earnedtrialcount=0;
            trialcount=0;
            correctcount=0;
            counting=true;
            finishcount=length(wrongImagestorage);
            myStart=GetSecs;
            
                    %images downloading
                   
                     if length(wrongImagestorage)<3;
                        picturefileList=[wrongImagestorage,originalpicturefileList(randperm(length(originalpicturefileList),3))];
                     else picturefileList = [wrongImagestorage];
                     end 
                     
                     revisedpicturefilelist={'ant.jpg','axe.jpg','banana.jpg','bat.jpg','belt.jpg','brush.jpg','canary.jpg', 'cape.jpg','cat.jpg','cherry.jpg','dog.jpg','dress.jpg','duck.jpg','eagle.jpg','fox.jpg','goat.jpg','goose.jpg','hat.jpg','jacket.jpg','kiwi.jpg','koala.jpg','ladder.jpg','lemon.jpg','lion.jpg','mole.jpg','peach.jpg','pencil.jpg','penguin.jpg','pig.jpg','pumpkin.jpg','rabbit.jpg','sheep.jpg','shirt.jpg','skunk.jpg','swan.jpg','tiger.jpg','tomato.jpg','zebra.jpg'}
            
            while counting
                    randpicturefileList=Shuffle(picturefileList);
            
                    %showing michelangelo pics
                    mymichelangelo=imread("michelangelo.png");
                    texmichelangelo=Screen('MakeTexture',win, mymichelangelo);
                    Screen('DrawTexture', win,texmichelangelo,[],[screenCntrX/5 screenCntrY/5 screenCntrX/1.5 screenCntrY/1.5]);
                    
                    %creating a matrix of 3 pictures
                    pictureSize=screenRect(3)/3;
                    gridsize=3;
                    displaySize=pictureSize*gridsize;
                    
                    rectCount=0;
                    for x=1:pictureSize:displaySize % outer loop %pictureSize=160
                         y=screensize(4)/2; % inner loop
	                     rectCount = rectCount+1;
                           my3pictures(rectCount,:)=[x y x+pictureSize/2 y+pictureSize/2];
                        
                    end
                    %centering
                    screenCntrX=screenRect(3)/2;
                    screenCntrY=screenRect(4)/2;
                    gridCntr=displaySize/2
                    my3pictures(:,[1 3])=my3pictures(:,[1 3])+screenCntrX-gridCntr+pictureSize/4;
                    
                    
                    
                    %Show 3 pics to choose
                    choosenpictures =[];
                    for kk = 1:3
                        fileName = randpicturefileList(kk);
                        myImage = imread(fileName);
                        tex = Screen('MakeTexture',win,myImage)
                        Screen('DrawTexture',win,tex,[],[my3pictures(kk,:)]);
                        choosenpictures = [choosenpictures fileName];            
                    end
            
            
                    %write the task
                    choosenpicturesIDX=randperm(3,1)
                    taskworddecided = char(choosenpictures(choosenpicturesIDX))
                    strtaskworddecided = convertCharsToStrings(taskworddecided)
                    picturefileList(picturefileList==strtaskworddecided) = []
                        
                    DrawFormattedText(win, ['Choose ' extractBefore(taskworddecided,'.jpg')],'center',screensize(4)/4,[255 255 255],[],[],[],[2]);
                    pause(.1)
                    Screen(win,'Flip');
                    
                    %Sound Stimuluation
                    SoundfileList=["ant.wav","axe.wav","banana.wav","bat.wav","belt.wav","brush.wav","canary.wav", "cape.wav","cat.wav","cherry.wav","dog.wav","dress.wav","duck.wav","eagle.wav","fox.wav","goat.wav","goose.wav","hat.wav","jacket.wav","kiwi.wav","koala.wav","ladder.wav","lemon.wav","lion.wav","mole.wav","peach.wav","pencil.wav","penguin.wav","pig.wav","pumpkin.wav","rabbit.wav","sheep.wav","shirt.wav","skunk.wav","swan.wav","tiger.wav","tomato.wav","zebra.wav"]
                    revisedsoundfilelist={'ant.wav','axe.wav','banana.wav','bat.wav','belt.wav','brush.wav','canary.wav', 'cape.wav','cat.wav','cherry.wav','dog.wav','dress.wav','duck.wav','eagle.wav','fox.wav','goat.wav','goose.wav','hat.wav','jacket.wav','kiwi.wav','koala.wav','ladder.wav','lemon.wav','lion.wav','mole.wav','peach.wav','pencil.wav','penguin.wav','pig.wav','pumpkin.wav','rabbit.wav','sheep.wav','shirt.wav','skunk.wav','swan.wav','tiger.wav','tomato.wav','zebra.wav'};
                    idxChoosen=find(strcmp(taskworddecided,revisedpicturefilelist));       
                    Soundstimulation=SoundfileList(idxChoosen)
                    %make the sound          
                    [y,Fs] = audioread(Soundstimulation)
                    sound(y,Fs)
                    
                    %Get mouse
                    noclick=true
                    while noclick 
                      [mouseX,mouseY,buttons]=GetMouse(win);
                      if buttons(1)
                              if mouseX>my3pictures(choosenpicturesIDX,1) && mouseX<my3pictures(choosenpicturesIDX,3) && mouseY>my3pictures(choosenpicturesIDX,2) && mouseY<my3pictures(choosenpicturesIDX,4);
                                  correctcount=correctcount+1
                                   while buttons(1)==1;
                                       [mouseX,mouseY,buttons]=GetMouse(win); 
                                   DrawFormattedText(win,['Correct!' '\n' 'Press enter to continue'] ,'center','center',[255 255 0],[],[],[],[2])
                                   Screen(win,'Flip');                                                                 
                                   noclick=false
                                   end
                              else DrawFormattedText(win,['Incorrect' '\n' 'Press enter to continue' '\n' '[Answer]'],'center',[screenCntrY/2],[255 0 0],[],[],[],[2])
                                  wrongImagestorage=[wrongImagestorage choosenpictures(choosenpicturesIDX)]
                                   wrongImage = imread(choosenpictures(choosenpicturesIDX));
                                   tex = Screen('MakeTexture',win,wrongImage)
                                   Screen('DrawTexture',win,tex,[],[screenCntrX/2 screenCntrY screenCntrX+(screenCntrX/2) screenCntrY+(screenCntrY/1.2)]);                    
                                   Screen(win,'Flip');
                                   noclick=false
                                   
                              end
            
                      end
                    end
                    trialcount=trialcount+1;
                    KbStrokeWait
            
                    %result         
                    if length(picturefileList)<3;
                       picturefileList=[wrongImagestorage,originalpicturefileList(randperm(length(originalpicturefileList),3))]
                    end      
                    if trialcount==finishcount;
                       earnedtrialcount=earnedtrialcount+trialcount
                       myStop=GetSecs;
                       avarage = correctcount/trialcount*100%avarage 
                       howlong=round([myStop-myStart],1)
                       background=imread("backgroundcertificate.jpg");
                       texbackground=Screen('MakeTexture',win, background);
                       Screen('DrawTexture', win,texbackground,[],[screenRect]);
                       mymoney=imread("money.png");
                       texmymoney=Screen('MakeTexture',win, mymoney);
                       Screen('DrawTexture', win,texmymoney,[],[screenCntrX/5 screenCntrY/5 screenCntrX/1.5 screenCntrY/1.5]);
                       
                       DrawFormattedText(win,['You learned ' num2str(trialcount) ' words in this lesson'],'center',[screenCntrY/1.3],[0 0 0],[],[],[],[2])
                       DrawFormattedText(win,['Total money ['  num2str(earnedtrialcount) '$]'],'center',[screenCntrY/2],[0 0 0],[],[],[],[2])
                       DrawFormattedText(win,['Earned   Commited  Good' '\n' ' [' num2str(trialcount) '$]       [' num2str(howlong) 's]         [' num2str(avarage) '%]'],'center','center',[0 0 0],[],[],[],[1])
                       DrawFormattedText(win,['Menu [1]' '\n' 'Quit [2]' '\n' 'Try Again [Enter]'],'center',[screenCntrY*1.3],[0 0 0],[],[],[],[1])
                       Screen(win,'Flip');
            
                       %To next or quit or try again the lesson.
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
                            counting=false
                       else counting=true
                            trialcount=0;
                            myStart=GetSecs;
                            correctcount=0;               
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
