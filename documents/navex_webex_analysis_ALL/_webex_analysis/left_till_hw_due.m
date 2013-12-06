Click_Data_All = {'2002-3-Fall-clickstream.txt','2003-1-Spri-clickstream.txt','2003-3-Fall-clickstream.txt','2004-1-Spri-clickstream.txt'};
Check_Data_All = {'2002-3-Fall-check.txt','2003-1-Spri-check.txt','2003-3-Fall-check.txt','2004-1-Spri-check.txt'};
Users_All = {'2002-3-Fall-users.txt','2003-1-Spri-users.txt','2003-3-Fall-users.txt','2004-1-Spri-users.txt'};
for j=1:4,
	Click_Data = load(Click_Data_All{j});
	Check_Data = load(Check_Data_All{j});
	Dates = [];	
	FDates = [];
	Users = (load(Users_All{j}))';
	User_clicks = [];
	FUser_clicks = [];
	for i=1:size(Check_Data,1),
		Dates=[Dates,[Check_Data(i)-5:Check_Data(i)+1]];
		if (Check_Data(i,2)==2),
			FDates=[FDates,[Check_Data(i)-5:Check_Data(i)+1]];
		end;
	end;
	for i=1:size(Users,2),
		User_Click_Data = [];
		idx = (Click_Data(:,2)==Users(i))';
		User_Click_Data = Click_Data(:,1);
		User_Click_Data = User_Click_Data(idx,:);
		User_clicks = [User_clicks; size(find(ismember(User_Click_Data,Dates)),1)];
		
		FUser_clicks = [FUser_clicks; size(find(ismember(User_Click_Data,FDates)),1)];
	end;
end;

A_prime = [];
U_prime = [];
Click_Data = {'2002-3-Fall-clickstream.txt','2003-1-Spri-clickstream.txt','2003-3-Fall-clickstream.txt','2004-1-Spri-clickstream.txt'};
Check_Data = {'2002-3-Fall-check.txt','2003-1-Spri-check.txt','2003-3-Fall-check.txt','2004-1-Spri-check.txt'};
Title_Data = {'Clickstream peaks 2002 Fall','Clickstream peaks 2003 Spring','Clickstream peaks 2003 Fall','Clickstream peaks 2004 Spring'};

filtered_users = [1, 21, 52, 62, 72, 82, 92, 102, 112, 122, 132, 142, 152, 162, 502, 712, 1322, 1432, 1552];
disp(['==================================================']);
for q=1:size(Check_Data,2),
	ANOVA=[];
	USERS=[];
	raw = load(Click_Data{q});%thwd
	checks_arr_raw = load(Check_Data{q});
	
	% a(:,find(~ismember(a,b)))
	
	%select only homeworks from checks
	checks_arr = checks_arr_raw(( checks_arr_raw(:,2)==0 ),:);
	%select only exams from checks
	%checks_arr = checks_arr_raw(( checks_arr_raw(:,2)~=0 ),:);
	
	%%% FILTER OUT EXAM RELATED CLICKS
	checks_arr_raw = sortrows(checks_arr_raw,1); 
	
	checks_arr = [[min(raw(:,1)),-1];checks_arr];
	checks = size(checks_arr,1);
	depth = 3;
	
	user_min = min(raw(:,2));
	user_max = max(raw(:,2));
	
	
%	[junk, distinct_users] = hist(raw(:,1),(user_min:user_max));
	distinct_users = unique(raw(:,2));
	
disp(['Clicks: ', num2str(size(raw,1)), ', to Filter: ', num2str(size(find(ismember(raw(:,2),filtered_users)),1)), ' (',num2str(100*size(find(ismember(raw(:,2),filtered_users)),1)/size(raw,1)),'%)']);
raw = raw( find(ismember(raw(:,2),filtered_users)==0),: );
disp(['Clicks new: ',num2str(size(raw,1))]);
	user_no = size(distinct_users,1);
	%ANOVA = cell(checks, 1);
	%for i=1:7
	%	ANOVA(i)={zeros(user_no * checks, 2)};
	%end;
	
%	ANOVA=zeros(user_no * depth, 2);
	ANOVA=zeros(user_no, depth);
	USERS=zeros(user_no,1); %user navigation in general
	
	for i=1:size(raw,1),
	    user_id = raw(i,2);
		day = raw(i,1);
	    user_idx = find(distinct_users==user_id);

% 		DIVISION 1.1
% 		GROUP 1: -1,0,1 days before assignment
% 		GROUP 2: 2,3,4,5 days before assignment
% 		GROUP 2: ~ all other days before assignment
	    for j=2:checks,
			days_till_hw_x = checks_arr(j)-day;
			USERS(user_idx) = USERS(user_idx) + 1;
			if((days_till_hw_x>=-1)&(days_till_hw_x<=1)),
				ANOVA(user_idx,1) = ANOVA(user_idx,1) + 1;
			elseif ((days_till_hw_x>=2)&(days_till_hw_x<=5)),
				ANOVA(user_idx,2) = ANOVA(user_idx,2) + 1;
			elseif((days_till_hw_x>=6)&(day>(checks_arr(j-1)+1))),
				ANOVA(user_idx,3) = ANOVA(user_idx,3) + 1;
			end;
		end;
		
% 		DIVISION 1
% 		GROUP 1: -1, 0, 1 days before assignment
% 		GROUP 2: 2,3,4 days before assignment
% 		GROUP 2: all other days before assignment
% 	    for j=2:checks,
% 			days_till_hw_x = checks_arr(j)-day;
% 			USERS(user_idx) = USERS(user_idx) + 1;
% 			if((days_till_hw_x>=-1)&(days_till_hw_x<=1)),
% 				ANOVA(user_idx,1) = ANOVA(user_idx,1) + 1;
% 			elseif ((days_till_hw_x>=2)&(days_till_hw_x<=4)),
% 				ANOVA(user_idx,2) = ANOVA(user_idx,2) + 1;
% 			elseif((days_till_hw_x>=5)&(day>(checks_arr(j-1)+1))),
% 				ANOVA(user_idx,3) = ANOVA(user_idx,3) + 1;
% 			end;
% 		end;

		
		% DIVISION 2
		% GROUP 1: 1 days before assignment
		% GROUP 2: -1, 0, 2 days before assignment
		% GROUP 2: all other days before assignment
	    %for j=2:checks,
		%	days_till_hw_x = checks_arr(j)-day;
		%	USERS(user_idx) = USERS(user_idx) + 1;
		%	if((days_till_hw_x>=0)&(days_till_hw_x<=1)),
		%		ANOVA(user_idx,1) = ANOVA(user_idx,1) + 1;
		%	elseif ((days_till_hw_x>=-1)&(days_till_hw_x<=2)),
		%		ANOVA(user_idx,2) = ANOVA(user_idx,2) + 1;
		%	elseif((days_till_hw_x>=3)&(day>(checks_arr(j-1)+1))),
		%		ANOVA(user_idx,3) = ANOVA(user_idx,3) + 1;
		%	end;
		%end;
		
	end;
	
	% FILTER OUT USERS WITH NO CLICKS
	navigation_cutout = 30; % min number of clicks in the 'before' period necessary to be considered habitual navigator
	
	USERS_non_empty = find(USERS>=navigation_cutout); % indexes of users with some navigation
	USERS_prime = USERS(USERS_non_empty,:); % filtered no navigation users
	ANOVA_prime = ANOVA(USERS_non_empty,:); % filtered no navigation users
	A_prime = [A_prime;ANOVA_prime];
	U_prime = [U_prime;USERS_prime];
	
	ClickEventF(Title_Data{q}, Click_Data{q}, Check_Data{q},q);
	hold on;
	hold off;
	
end; % END OF DATASETS

figure(q+1);
boxplot(A_prime);

A_p=A_prime(:);
A_n=([ones(size(A_prime,1),1)*1 ;ones(size(A_prime,1),1)*2;ones(size(A_prime,1),1)*3]);
set(gca,'XTickLabel',{'On test','Before test','Other'})
xlabel('');
figure(q+2);
grpstats(A_p,A_n,0.05);
set(gca,'XTickLabel',{'On test','Before test','Other'})
xlabel('');

%	A_hat = zeros(size(U_prime,1)*depth,2);
%	for i=1:depth,
%		for j=1:size(U_prime,1),
%			A_hat(size(U_prime,1)*(i-1)+j,1) = (i-1);
%			A_hat(size(U_prime,1)*(i-1)+j,2) = A_prime(j,i);
%		end;
%	end;
