#!/usr/bin/env bash

evaluate_hand() {
    local hand=$1 card rank_text suit first_suit='' rank distinct=0 straight=0 straight_high=0 flush=1 category i
    local -a cards=() counts=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) ranks=() pairs=() trips=() quads=() tie=(0 0 0 0 0)
    read -r -a cards <<< "$hand"
    ((${#cards[@]} == 5)) || return 1
    total=0
    for card in "${cards[@]}"; do
        rank_text=${card%?}
        suit=${card:${#card}-1:1}
        case $rank_text in
            A) rank=14 ;; K) rank=13 ;; Q) rank=12 ;; J) rank=11 ;; 10) rank=10 ;;
            [2-9]) rank=$rank_text ;;
            *) return 1 ;;
        esac
        counts[rank]=$((counts[rank]+1))
        ranks+=("$rank")
        total=$((total+rank))
        if [[ -z $first_suit ]]; then first_suit=$suit; elif [[ $suit != "$first_suit" ]]; then flush=0; fi
    done
    for ((rank=14; rank>=2; rank--)); do
        if ((counts[rank] > 0)); then ((distinct+=1)); fi
        case ${counts[rank]} in
            4) quads+=("$rank") ;;
            3) trips+=("$rank") ;;
            2) pairs+=("$rank") ;;
        esac
    done
    if ((distinct == 5)); then
        highest=0; lowest=14
        for rank in "${ranks[@]}"; do
            ((rank > highest)) && highest=$rank
            ((rank < lowest)) && lowest=$rank
        done
        if ((highest-lowest == 4)); then straight=1; straight_high=$highest
        elif ((counts[14] == 1 && counts[5] == 1 && counts[4] == 1 && counts[3] == 1 && counts[2] == 1)); then straight=1; straight_high=5
        fi
    fi
    sorted_ranks=()
    for ((rank=14; rank>=2; rank--)); do
        for ((i=0; i<counts[rank]; i++)); do sorted_ranks+=("$rank"); done
    done

    if ((straight && flush)); then
        category=8; tie[0]=$straight_high
    elif ((${#quads[@]} > 0)); then
        category=7; tie[0]=${quads[0]}
        for rank in "${sorted_ranks[@]}"; do if ((rank != tie[0])); then tie[1]=$rank; break; fi; done
    elif ((${#trips[@]} > 0 && ${#pairs[@]} > 0)); then
        category=6; tie[0]=${trips[0]}; tie[1]=${pairs[0]}
    elif ((flush)); then
        category=5
        for ((i=0; i<5; i++)); do tie[i]=${sorted_ranks[i]}; done
    elif ((straight)); then
        category=4; tie[0]=$straight_high
    elif ((${#trips[@]} > 0)); then
        category=3; tie[0]=${trips[0]}; i=1
        for rank in "${sorted_ranks[@]}"; do if ((rank != tie[0])); then tie[i]=$rank; ((i+=1)); fi; done
    elif ((${#pairs[@]} == 2)); then
        category=2; tie[0]=${pairs[0]}; tie[1]=${pairs[1]}; i=2
        for rank in "${sorted_ranks[@]}"; do if ((rank != tie[0] && rank != tie[1])); then tie[i]=$rank; break; fi; done
    elif ((${#pairs[@]} == 1)); then
        category=1; tie[0]=${pairs[0]}; i=1
        for rank in "${sorted_ranks[@]}"; do if ((rank != tie[0])); then tie[i]=$rank; ((i+=1)); fi; done
    else
        category=0
        for ((i=0; i<5; i++)); do tie[i]=${sorted_ranks[i]}; done
    fi
    hand_score=$category
    for ((i=0; i<5; i++)); do hand_score=$((hand_score*15+tie[i])); done
}

best_score=-1
winners=()
for hand in "$@"; do
    evaluate_hand "$hand" || exit 1
    if ((hand_score > best_score)); then
        best_score=$hand_score
        winners=("$hand")
    elif ((hand_score == best_score)); then
        winners+=("$hand")
    fi
done
printf '%s\n' "${winners[@]}"
