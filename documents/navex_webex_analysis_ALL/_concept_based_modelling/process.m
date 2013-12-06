NExamp = 66;
NConc = 235;

raw = load('act_conc_W.txt');
page_lec = load('page_lec_W.txt');
page_lec = sortrows(page_lec,[2,1]); 

inci = zeros(NExamp,NConc); %incidency matr #e*#c
for i=1:size(raw,1),
    inci(raw(i,1),raw(i,2)) = inci(raw(i,1),raw(i,2)) + 1;
end;

%PN
i1 = (inci>0)*1;
in = zeros(NExamp,NConc);
out = zeros(NExamp,NConc);
chapter_defns = []; % concepts chapters define
transC = [1:NExamp];
transP = []; % processed

for i=min(page_lec(:,2)):max(page_lec(:,2)), % all chapters

    defined_cncpts = zeros(1,NConc);
    
    candidate_ids = page_lec(find(page_lec(:,2) == i),:);
    candidate_ids = candidate_ids(:,1)';
    
    to_del_list = candidate_ids;%[];
    % define candidates
    learnt = (sum(out)>0)*1;
    
    %ADD
    for i=1:size(to_del_list,2),
        gIDx = to_del_list(i); % global index
        full_c = i1(gIDx,:);
        in_s = full_c .* learnt;
        out_s = full_c - in_s;
        % Adding        
        in(gIDx,:) = in_s;
        out(gIDx,:) = out_s;
        
        defined_cncpts = (defined_cncpts + out_s) > 0;
    end;
    
    chapter_defns = [chapter_defns; defined_cncpts];
    
    transP = [transP, to_del_list];
    transC = setdiff(transC, to_del_list);
end;




STOP = true
result = [];
for i=1:NExamp,
	for j=1:NConc,
		if(in(i,j)>0),
			result = [result; i, j, 0];
		end;
	end;
	for j=1:NConc,
		if(out(i,j)>0),
			result = [result; i, j, 1];
		end;
	end;
end;
%exit;

while (size(transC,1)>0), % while not all pocessed
    
    to_del_list = [];
    % define candidates
    learnt = (sum(out)>0)*1;
    no_learnt = size(find(learnt),2);
    learnt_matr = ones(size(transC,2),1) * learnt;
    i_tolearn = i1(transC,:) - ( learnt_matr );

    cand =  sum((i1(transC,:) .* learnt_matr)'); % list of matches 0, no_learnt<>;
    if(mean(cand)==0),
        cand = ones(size(cand));
    end;
    
    left_behind = (cand<no_learnt)*1; % mask
    % add left behind
%    to_del_list = [to_del_list, ( transC(:,find(left_behind)) )'];
    
    % candidates
    cand_pure = cand .* ((~left_behind)*1);
    
    
    % find candidates' min size of unlearnt
    cand_sizes = sum(i_tolearn(find(cand),:)');
    cand_mins = cand_sizes == min(cand_sizes);
    % add new minimum candidates
    to_del_list = [to_del_list, ( transC(:,find(cand_mins)) )];
    
    %ADD
    for i=1:size(to_del_list,2),
        gIDx = to_del_list(i); % global index
        full_c = i1(gIDx,:);
        in_s = full_c .* learnt;
        out_s = full_c - in_s;
        % Adding        
        in(gIDx,:) = in_s;
        out(gIDx,:) = out_s;
    end;
    transP = [transP, to_del_list];
    transC = setdiff(transC, to_del_list);
end;



r = 0;
% HAVE COMMON KW: ~isempty(find(i1(1,:).*i1(2,:)))