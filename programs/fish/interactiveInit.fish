function back
  set -l root (git rev-parse --show-toplevel)
  if test $status -eq 0
    cd $root
  end
end

function cdd
  set -l wroot $PWD
  if test -n $args[1]
    set -l wroot $args[1]
  end
  cd (find $wroot -type d -print | fzf)
end
