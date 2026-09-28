public static class BinarySearch
{
    public static int Find(int[] input, int value)
    {
        var low = 0;
        var high = input.Length - 1;

        while (low <= high)
        {
            var middle = low + (high - low) / 2;
            if (input[middle] == value)
            {
                return middle;
            }

            if (input[middle] < value)
            {
                low = middle + 1;
            }
            else
            {
                high = middle - 1;
            }
        }

        return -1;
    }
}
