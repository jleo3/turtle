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

  def test_adjusts_unit_size_based_on_account_size
    n = 0.0141
    account_size = 100_000
    dollars_per_point = 42_000

    assert_equal 1, unit_size(n, account_size, dollars_per_point)
  end

  def unit_size(n, account_size, dollars_per_point)
    (one_percent_of_account(account_size) / (n * dollars_per_point)).to_int
  end

  def one_percent_of_account size
    size * 0.01
  end
end
