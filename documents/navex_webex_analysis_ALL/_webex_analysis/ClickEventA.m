%	ClickEventA - does click stream peaks with overlays of homeworks,
%		filnals, etc (input from arrays)
%	Inputs - all filenames
%		0. The title of the plot
%		1. {number, user_id} number representation of dates on which the
%			clicks occured and the user id 
%			E.g.	{number, date} actual date given as an example
%				transformation date-number can be done in Excel
%				37536	07.10.2002
%				37537	08.10.2002
%				37546	17.10.2002
%				37548	19.10.2002
%				37559	30.10.2002
%		2. {number, code} number representations of the date and code of
%			the event 0 - HW, 1 - Mid, 2 - Final
%
%	Output 
%		The plot

function result = ClickEventA (plot_title, clickstream, checkpoint, fig)

% load data
clickstream = clickstream(:,1); % filter out user ids
checkpoint = load(checkpoint_filename);

homework = checkpoint((checkpoint(:,2)==0),1);
midterm = checkpoint((checkpoint(:,2)==1),1);
final = checkpoint((checkpoint(:,2)==2),1);

% bin the clickstream
bins = min(min(clickstream)):max(max(clickstream));
[Counts, Values] = hist(clickstream(:),bins);

% plot clickstream histogram in BLUE, homeworks at height 25 in RED,
% midterm at height 50 in GREEN, in final at height 50 in BLACK
figure(fig);
plot((Values-2), Counts,'-b', homework,25*ones(size(homework)),'*r', midterm,50*ones(size(midterm)),'og', final,50*ones(size(final)),'sk');
ylabel('Number of clicks');
title([plot_title]);
legend('Clicks','HW','Midterm','Final',0);
set(gca,'XTickLabel',{});
