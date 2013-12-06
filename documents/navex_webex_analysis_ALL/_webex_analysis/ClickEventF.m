%	ClickEventF - does click stream peaks with overlays of homeworks,
%		filnals, etc (input from files)
%	
%	Inputs - all filenames
%		1. The title of the plot
%		2. {number, user_id} number representation of dates on which the
%			clicks occured and the user id 
%			E.g.	{number, date} actual date given as an example
%				transformation date-number can be done in Excel
%				37536	07.10.2002
%				37537	08.10.2002
%				37546	17.10.2002
%				37548	19.10.2002
%				37559	30.10.2002
%		3. {number, code} number representations of the date and code of
%			the event 0 - HW, 1 - Mid, 2 - Final, 3 - Quiz
%		4. number of the figure to draw at (useful at batch moode)
%		5. scale - the check marks will be layered by hight as
%			HW-1*scale, Q-2*scale, F,M-3*scale
%
%	Output 
%		The plot

function result = ClickEventF (plot_title, clickstream_filename, checkpoint_filename, fig, scale)

% load data
clickstream = load(clickstream_filename);
clickstream = clickstream(:,1); % filter out user ids
checkpoint = load(checkpoint_filename);

homework = checkpoint((checkpoint(:,2)==0),1);
midterm = checkpoint((checkpoint(:,2)==1),1);
final = checkpoint((checkpoint(:,2)==2),1);
quiz = checkpoint((checkpoint(:,2)==3),1);

% bin the clickstream
bins = min(min(clickstream)):max(max(clickstream));
[Counts, Values] = hist(clickstream(:),bins);

% plot clickstream histogram in BLUE, homeworks at height 25 in RED,
% midterm at height 50 in GREEN, in final at height 50 in BLACK
figure(fig);
plot(Values, Counts,'-b', homework,scale*ones(size(homework)),'*r', quiz,2*scale*ones(size(quiz)),'xm', midterm,3*scale*ones(size(midterm)),'og', final,3*scale*ones(size(final)),'sk');
hold;
plot([homework';homework'],[max(max(Counts))*ones(1,size(homework,1));min(min(Counts))*ones(1,size(homework,1))],'-r')
plot([quiz';quiz'],[max(max(Counts))*ones(1,size(quiz,1));min(min(Counts))*ones(1,size(quiz,1))],'-m')
plot([midterm';midterm'],[max(max(Counts))*ones(1,size(midterm,1));min(min(Counts))*ones(1,size(midterm,1))],'-g')
plot([final';final'],[max(max(Counts))*ones(1,size(final,1));min(min(Counts))*ones(1,size(final,1))],'-k')
hold;
ylabel('Number of clicks');
title([plot_title]);
legend('Clicks','HW','Quiz','Midterm','Final',0);
set(gca,'XTickLabel',{});
