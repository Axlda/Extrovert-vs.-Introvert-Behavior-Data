
function scores = social_activity_score(friends,posts,events,outside)
nf = friends/15;
np = posts /10;
ne = events/ 10;
no = outside /10;
scores = 0.3*nf+0.2*np+0.3*ne+ 0.2*no;
end



%COMPUTES A WEIGHTED SCORE FOR SOCIAL ACTIVITY
%Inputs:
%friends 
%posts 
%events 
%outside 
   
% Output:
%  scores 

%normalize each input to a 0 to 1 scale /assuming known max = 15 for friends and 10 for others)