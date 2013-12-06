clear;
%load a concept cell array
[a,b]=textread('_concepts.txt', '%u\t%s');
a=num2cell(a);
concepts=[a,b];

%%%% get a CELL column of concept ids
% A=concepts(:,1)
%%%% get a NUMERIC column of concept ids
% A=[concepts{:,1}]'
%%%% get a cell array of concept names
% B=concepts(:,2)



%load activities
[a,b]=textread('_activitiesQ.txt', '%u\t%s');
a=num2cell(a);
activities=[a,b];

%%%% get a CELL column of activity 
% A=activities(:,1)
%%%% get a NUMERIC column of activity ids
% A=[activities{:,1}]'
%%%% get a cell array of activity names
% B=activities(:,2)

%load indexing
[a,b]=textread('_indexingQ.txt', '%s\t%s');
indexing_raw=[a,b];

%load activity-lecture data
[a,b]=textread('_activity_lecture_Q.txt', '%s\t%u');
aa = zeros(size(a));
for i=1:size(a,1),
    activ_index = find(strcmp(activities(:,2),a(i)));
    aa(i) = activ_index;
end;
activity_lecture=[aa,b];

% max ids of concepts and activities
max_conc =max([concepts{:,1}]');
max_activ =max([activities{:,1}]');
%create an indexing incidence matrix
indexing_inci=zeros(max_activ,max_conc);
for i=1:size(indexing_raw,1),
    activ_index = find(strcmp(activities(:,2),indexing_raw(i,1)));
    conc_index = find(strcmp(concepts(:,2),indexing_raw(i,2)));
    indexing_inci( activ_index, conc_index) = indexing_inci( activ_index, conc_index) + 1;
end;

% create inputs outputs martices
indexing_in=zeros(max_activ,max_conc);
indexing_out=zeros(max_activ,max_conc);

i1 = (indexing_inci>0)*1; % zero/non-zero version of incidence indexing matrix
chapter_defs = []; % concepts defined in chapters
transC = [1:max_activ]; % current
transP = []; % processed concepts

% MAIN PROCEDURE
for i=min(activity_lecture(:,2)):max(activity_lecture(:,2)), % all chapters

    defined_cncpts = zeros(1,max_conc);
    
    candidate_ids = activity_lecture(find(activity_lecture(:,2) == i),:);
    candidate_ids = candidate_ids(:,1)';
    
    to_del_list = candidate_ids;%[];
    % define candidates
    learnt = (sum(indexing_out)>0)*1;
    
    %ADD
    for i=1:size(to_del_list,2),
        gIDx = to_del_list(i); % global index
        full_c = i1(gIDx,:);
        in_s = full_c .* learnt;
        out_s = full_c - in_s;
        % Adding        
        indexing_in(gIDx,:) = in_s;
        indexing_out(gIDx,:) = out_s;
        
        defined_cncpts = (defined_cncpts + out_s) > 0;
    end;
    
    chapter_defs = [chapter_defs; defined_cncpts];
    
    transP = [transP, to_del_list];
    transC = setdiff(transC, to_del_list);
end;

indexing_in = indexing_in .* indexing_inci;
indexing_out = indexing_out .* indexing_inci;

result = [];
for i=1:max_activ,
	for j=1:max_conc,
		if(indexing_in(i,j)>0),
            if(i==24),
                a_break = 0;
            end;
			result = [result; i, j, indexing_in(i,j), 0];
		end;
	end;
	for j=1:max_conc,
		if(indexing_out(i,j)>0),
			result = [result; i, j, indexing_out(i,j), 1];
		end;
	end;
end;
stop=[];
