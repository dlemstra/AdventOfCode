require_relative "chronalClassification"
require "test/unit"

class RunTests < Test::Unit::TestCase

    def test_addr
        register = Register.new(1, 2, 3, 4)
        register.addr(1, 2, 0)
        assert_equal([5, 2, 3, 4], register.state)
    end

    def test_addi
        register = Register.new(1, 2, 3, 4)
        register.addi(1, 5, 1)
        assert_equal([1, 7, 3, 4], register.state)
    end

    def test_mulr
        register = Register.new(1, 2, 3, 4)
        register.mulr(1, 2, 2)
        assert_equal([1, 2, 6, 4], register.state)
    end

    def test_mulir
        register = Register.new(1, 2, 3, 4)
        register.muli(1, 5, 3)
        assert_equal([1, 2, 3, 10], register.state)
    end

    def test_banr
        register = Register.new(1, 2, 3, 4)
        register.banr(2, 3, 0)
        assert_equal([0, 2, 3, 4], register.state)
    end

    def test_bani
        register = Register.new(1, 2, 3, 4)
        register.bani(2, 3, 1)
        assert_equal([1, 3, 3, 4], register.state)
    end

    def test_borr
        register = Register.new(1, 2, 3, 4)
        register.borr(2, 3, 2)
        assert_equal([1, 2, 7, 4], register.state)
    end

    def test_bori
        register = Register.new(1, 2, 3, 4)
        register.bori(2, 3, 3)
        assert_equal([1, 2, 3, 3], register.state)
    end

    def test_setr
        register = Register.new(1, 2, 3, 4)
        register.setr(0, 1, 1)
        assert_equal([1, 1, 3, 4], register.state)
    end

    def test_seti
        register = Register.new(1, 2, 3, 4)
        register.seti(0, 1, 0)
        assert_equal([0, 2, 3, 4], register.state)
    end

    def test_gtir
        register = Register.new(1, 2, 3, 4)
        register.gtir(2, 1, 2)
        assert_equal([1, 2, 0, 4], register.state)
    end

    def test_gtir2
        register = Register.new(1, 2, 3, 4)
        register.gtir(3, 1, 2)
        assert_equal([1, 2, 1, 4], register.state)
    end

    def test_gtri
        register = Register.new(1, 2, 3, 4)
        register.gtri(0, 0, 3)
        assert_equal([1, 2, 3, 1], register.state)
    end

    def test_gtri2
        register = Register.new(1, 2, 3, 4)
        register.gtri(0, 1, 3)
        assert_equal([1, 2, 3, 0], register.state)
    end

    def test_gtrr
        register = Register.new(1, 2, 3, 4)
        register.gtrr(1, 2, 0)
        assert_equal([0, 2, 3, 4], register.state)
    end

    def test_gtrr2
        register = Register.new(1, 2, 3, 4)
        register.gtrr(2, 1, 1)
        assert_equal([1, 1, 3, 4], register.state)
    end

    def test_eqir
        register = Register.new(1, 2, 3, 4)
        register.eqir(1, 2, 1)
        assert_equal([1, 0, 3, 4], register.state)
    end

    def test_eqir2
        register = Register.new(1, 2, 3, 4)
        register.eqir(3, 2, 1)
        assert_equal([1, 1, 3, 4], register.state)
    end

    def test_eqri
        register = Register.new(1, 2, 3, 4)
        register.eqri(1, 2, 2)
        assert_equal([1, 2, 1, 4], register.state)
    end

    def test_eqri2
        register = Register.new(1, 2, 3, 4)
        register.eqri(1, 0, 2)
        assert_equal([1, 2, 0, 4], register.state)
    end

    def test_eqrr
        register = Register.new(1, 2, 3, 4)
        register.eqrr(1, 2, 3)
        assert_equal([1, 2, 3, 0], register.state)
    end

    def test_eqrr2
        register = Register.new(1, 3, 3, 4)
        register.eqrr(1, 2, 3)
        assert_equal([1, 3, 3, 1], register.state)
    end

    def test_case1
        input = %{Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]}
        assert_equal(1, chronalClassification(input.split("\n")))
    end
end