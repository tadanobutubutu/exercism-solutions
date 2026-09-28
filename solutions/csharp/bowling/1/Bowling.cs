public class BowlingGame
{
    private readonly List<int> rolls = [];

    public void Roll(int pins) 
    {
        if (pins is < 0 or > 10)
        {
            throw new ArgumentException("A roll must knock down between 0 and 10 pins.", nameof(pins));
        }

        var candidate = new List<int>(rolls) { pins };
        if (!IsValidRollSequence(candidate, out _))
        {
            throw new ArgumentException("The roll is invalid for the current frame.", nameof(pins));
        }
        rolls.Add(pins);
    }

    public int? Score()
    {
        if (!IsValidRollSequence(rolls, out bool complete) || !complete)
        {
            throw new ArgumentException("The game is not complete.");
        }

        int score = 0;
        int rollIndex = 0;
        for (int frame = 0; frame < 10; frame++)
        {
            if (rolls[rollIndex] == 10)
            {
                score += 10 + rolls[rollIndex + 1] + rolls[rollIndex + 2];
                rollIndex++;
            }
            else
            {
                int frameScore = rolls[rollIndex] + rolls[rollIndex + 1];
                score += frameScore;
                if (frameScore == 10)
                {
                    score += rolls[rollIndex + 2];
                }
                rollIndex += 2;
            }
        }

        return score;
    }

    private static bool IsValidRollSequence(IReadOnlyList<int> rolls, out bool complete)
    {
        complete = false;
        int index = 0;

        for (int frame = 0; frame < 9; frame++)
        {
            if (index >= rolls.Count)
            {
                return true;
            }

            if (rolls[index] == 10)
            {
                index++;
                continue;
            }

            if (index + 1 >= rolls.Count)
            {
                return true;
            }
            if (rolls[index] + rolls[index + 1] > 10)
            {
                return false;
            }
            index += 2;
        }

        if (index >= rolls.Count)
        {
            return true;
        }

        int first = rolls[index];
        if (first == 10)
        {
            if (rolls.Count == index + 1) return true;
            int second = rolls[index + 1];
            if (second < 10 && second + (rolls.Count > index + 2 ? rolls[index + 2] : 0) > 10)
            {
                return false;
            }
            if (rolls.Count < index + 3) return true;
            if (second < 10 && rolls.Count != index + 3) return false;
            if (second == 10 && rolls.Count > index + 3) return false;
            complete = rolls.Count == index + 3;
            return true;
        }

        if (rolls.Count == index + 1) return true;
        int secondRoll = rolls[index + 1];
        if (first + secondRoll > 10) return false;
        bool spare = first + secondRoll == 10;
        if (spare)
        {
            if (rolls.Count == index + 2) return true;
            if (rolls.Count > index + 3) return false;
            complete = rolls.Count == index + 3;
            return true;
        }

        if (rolls.Count > index + 2) return false;
        complete = rolls.Count == index + 2;
        return true;
    }
}
