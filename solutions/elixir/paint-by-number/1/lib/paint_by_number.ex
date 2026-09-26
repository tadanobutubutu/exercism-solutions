defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    palette_bit_size(color_count, 0)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    pixel_size = palette_bit_size(color_count)
    <<pixel_color_index::size(pixel_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    if bit_size(picture) == 0 do
      nil
    else
      pixel_size = palette_bit_size(color_count)
      <<pixel::size(^pixel_size), _rest::bitstring>> = picture
      pixel
    end
  end

  def drop_first_pixel(picture, color_count) do
    pixel_size = palette_bit_size(color_count)

    if bit_size(picture) < pixel_size do
      <<>>
    else
      <<_pixel::size(^pixel_size), rest::bitstring>> = picture
      rest
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end

  defp palette_bit_size(color_count, bit_size) do
    if 2 ** bit_size >= color_count do
      bit_size
    else
      palette_bit_size(color_count, bit_size + 1)
    end
  end
end
