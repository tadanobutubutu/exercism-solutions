USING: arrays deques dlists hash-sets kernel math math.order sequences sets ;
IN: two-bucket

ERROR: goal-not-reachable ;

:: state-key ( bucket-one bucket-two capacity-two -- key )
    bucket-one capacity-two 1 + * bucket-two + ;

:: enqueue-state ( bucket-one bucket-two moves capacity-one capacity-two
        start visited frontier -- )
    bucket-one bucket-two capacity-two state-key :> key
    key visited in? not [
        start "one" = [
            bucket-one zero? bucket-two capacity-two = and
        ] [
            bucket-two zero? bucket-one capacity-one = and
        ] if not [
            key visited adjoin
            bucket-one bucket-two moves 3array frontier push-back
        ] when
    ] when ;

:: measure ( cap1 cap2 goal start -- moves goal-bucket other )
    goal 0 < goal cap1 > goal cap2 > and or [ goal-not-reachable ] when
    HS{ } clone :> visited
    <dlist> :> frontier
    start "one" = [ cap1 ] [ 0 ] if :> initial-one
    start "one" = [ 0 ] [ cap2 ] if :> initial-two
    initial-one initial-two cap2 state-key visited adjoin
    initial-one initial-two 1 3array frontier push-back
    f :> answer!
    [ frontier deque-empty? answer or ] [
        frontier pop-front :> entry
        0 entry nth :> bucket-one
        1 entry nth :> bucket-two
        2 entry nth :> moves
        bucket-one goal = [
            moves "one" bucket-two 3array answer!
        ] [
            bucket-two goal = [
                moves "two" bucket-one 3array answer!
            ] when
        ] if
        moves 1 + :> next-moves
        0 bucket-two next-moves cap1 cap2 start visited frontier enqueue-state
        bucket-one 0 next-moves cap1 cap2 start visited frontier enqueue-state
        cap1 bucket-two next-moves cap1 cap2 start visited frontier enqueue-state
        bucket-one cap2 next-moves cap1 cap2 start visited frontier enqueue-state
        cap2 bucket-two - :> room-two
        bucket-one room-two min :> to-two
        bucket-one to-two - bucket-two to-two + next-moves cap1 cap2
            start visited frontier enqueue-state
        cap1 bucket-one - :> room-one
        bucket-two room-one min :> to-one
        bucket-one to-one + bucket-two to-one - next-moves cap1 cap2
            start visited frontier enqueue-state
    ] until
    answer [
        0 answer nth
        1 answer nth
        2 answer nth
    ] [ goal-not-reachable ] if ;
