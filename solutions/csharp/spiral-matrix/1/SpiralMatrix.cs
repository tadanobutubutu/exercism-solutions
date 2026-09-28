public class SpiralMatrix
{
    public static int[,] GetMatrix(int size)
    {
        if (size <= 0)
        {
            return new int[0, 0];
        }

        var matrix = new int[size, size];
        var top = 0;
        var bottom = size - 1;
        var left = 0;
        var right = size - 1;
        var value = 1;

        while (top <= bottom && left <= right)
        {
            for (var column = left; column <= right; column++) matrix[top, column] = value++;
            top++;

            for (var row = top; row <= bottom; row++) matrix[row, right] = value++;
            right--;

            if (top <= bottom)
            {
                for (var column = right; column >= left; column--) matrix[bottom, column] = value++;
                bottom--;
            }

            if (left <= right)
            {
                for (var row = bottom; row >= top; row--) matrix[row, left] = value++;
                left++;
            }
        }

        return matrix;
    }
}
