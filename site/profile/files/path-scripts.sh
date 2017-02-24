for d in $( find -L /opt/scripts -type f -executable ! \( -path '**/.git/*' -o -path '**/conf/*' -o -path '**/cron*' -o -path '**/dlds*' -o -path '**/dtrace*' \) -printf '%h\n' | uniq ); do
    case ":${PATH}:" in
        *:"$1":*)
          ;;
        *)
          PATH="${PATH}:${d}"
          ;;
      esac
done

export PATH
