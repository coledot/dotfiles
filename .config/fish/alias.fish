function cdtssh; sudo ssh -i ~/.ssh/id_rsa -Y cole@cole_inigral; end

function ll; ls -l; end
function la; ls -la; end
function ltr; ls -ltr; end

function psx; ps axuww; end

function fdf; find . -type f; end
function fdd; find . -type d; end

function gcl; git clone $argv; end
function gco; git checkout $argv; end
function glg; git lg $argv; end
function glo; git log $argv; end
function gst; git status; end
function gdf; git diff $argv; end
function gad; git add $argv; end
function gcm; git commit -m $argv; end
function grs; git reset $argv; end
function grm; git rm $argv; end
function gmg; git merge $argv; end
function gll; git pull; end
function gsh; git push $argv; end
function gbl; git blame $argv; end
function gtg; git tag $argv; end
function gmv; git mv $argv; end
function gbs; git bisect $argv; end
function gbr; git branch $argv; end

function gash; git stash $argv; end
function gcmm; git commit; end
function gcod; git checkout -- .; end
function gshv; git shove; end

function gadcm; git add .; and git commit -m $argv; end

function rlsc; rails c $argv; end

function pspec; rake parallel:spec; cat log/parallel_summary.log; end
function fpspec; rake parallel:setup; pspec; end

# deploy the current branch to staging
function stagedis; cap staging deploy HOSTS=dev5.schoolsapp.com BRANCH=(git rev-parse --abbrev-ref HEAD); end

function psgsrt; passenger start; end
function psgstp; passenger stop; end

if test -e (which task);
  function sup; clear; task next; end
end

function keyon; ssh-add -t 0; end
function keyoff; ssh-add -D; end
function keyls; ssh-add -l; end

function vgr; vagrant $argv; end

while read line;
  if echo $line | egrep '^[ \t]*$|^[ \t]*#' >/dev/null;
    continue 
  end
  function $line; ssh {$_}.inigral.com; end
end < ~/.inigral_ssh_aliases
