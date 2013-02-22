# Calculating N. N is the 20-day exponential moving average of the True Range (ATR)
#
# N represents the average range in price movement that a given market makes in a single day
#
# True Range(TR) = Max(H-L, H-PDC, PDC-L)

# H - Current High
# L - Current Low
# PDC - Previous Day's Close
#
# N = (19 * PDN + TR)/20
#
# PDN - Previous Day's N

# Market Dollar Volatility = N + Dollars per Point
#
# Volatility Adjusted Position Unis
# VAPU = 1% of Account / Market Dollar Volatility

#! /usr/bin/env ruby

require 'rubygems'
require 'test/unit'

class NTest < Test::Unit::TestCase
  def test_calculates_unit_size
    n = 0.0141
    account_size = 1_000_000
    dollars_per_point = 42_000
    
    assert_equal 16, unit_size(n, account_size, dollars_per_point)
  end

  def test_account_size_too_small
    n = 0.0141
    account_size = 10_000
    dollars_per_point = 42_000

    assert_equal 0, unit_size(n, account_size, dollars_per_point)
  end

  def test_calculates_true_range
    high_12_4_02 = 0.7420
    low_12_4_02 = 0.7140
    close_12_3_02 = 0.7389

    assert_equal 0.0280, true_range(high_12_4_02, low_12_4_02, close_12_3_02)
  end

  def test_true_range_when_high_minus_low_is_max
    high = 0.5
    low = 0.1
    previous_close = 0.3

    assert_equal high - low, true_range(high, low, previous_close)
  end

  def true_range current_high, current_low, previous_close
# True Range(TR) = Max(H-L, H-PDC, PDC-L)
    [current_high - current_low, 
     current_high - previous_close,
     previous_close - current_low].max.round(4)
  end

  def unit_size n, account_size, dollars_per_point
    (one_percent_of_account(account_size) / (n * dollars_per_point)).to_int
  end

  def one_percent_of_account size
    size * 0.01
  end
end
