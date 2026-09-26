=begin
Write your code for the 'Phone Number' exercise in this file. Make the tests in
`phone_number_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/phone-number` directory.
=end

class PhoneNumber
  def self.clean(number)
    return unless number.match?(/\A[+\d().\s-]+\z/)

    digits = number.gsub(/\D/, '')
    if digits.length == 11
      return unless digits.start_with?('1')

      digits = digits[1..]
    end

    return unless digits.match?(/\A[2-9]\d{2}[2-9]\d{6}\z/)

    digits
  end
end
