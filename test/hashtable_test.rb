require_relative "test_helper"
require "hashtable"


class HashtableTest < Minitest::Test

  KEY_VALS = ("a".."c").each_with_index.to_a
  UNUSED_KEY_VAL = [
    KEY_VALS.map(&:first).max_by(&:length) + "!",
    KEY_VALS.map(&:last).max + 1
  ]

  def make_hashtable(key_vals)
    key_vals.reduce(Hashtable.new){|h, (k, v)| h.set(k, v); h }
  end

  def make_model(key_vals)
    Hash[key_vals]
  end

  def assert_invariants(key_vals, model, hashtable)
    key_vals.each do |k, v|
      if model.key?(k)
        assert_equal model[k], hashtable.get(k)
      else
        assert_nil hashtable.get(k)
      end
    end
  end

  def test_get_existing_key
    model = make_model(KEY_VALS)
    hashtable = make_hashtable(KEY_VALS)
    assert_invariants KEY_VALS, model, hashtable
  end

  def test_get_unused_key
    model = make_model(KEY_VALS)
    hashtable = make_hashtable(KEY_VALS)
    assert_invariants (KEY_VALS + [UNUSED_KEY_VAL]), model, hashtable
  end

  def test_set_existing_key
    KEY_VALS.each do |k, v|
      model = make_model(KEY_VALS)
      hashtable = make_hashtable(KEY_VALS)

      model[k] = v * 10
      hashtable.set(k, v * 10)

      assert_invariants KEY_VALS, model, hashtable
    end
  end

  def test_set_unused_key
    model = make_model(KEY_VALS)
    hashtable = make_hashtable(KEY_VALS)

    model[UNUSED_KEY_VAL[0]] = UNUSED_KEY_VAL[1]
    hashtable.set(UNUSED_KEY_VAL[0], UNUSED_KEY_VAL[1])

    assert_invariants (KEY_VALS + [UNUSED_KEY_VAL]), model, hashtable
  end

  def test_remove_existing_key
    KEY_VALS.each do |k, v|
      model = make_model(KEY_VALS)
      hashtable = make_hashtable(KEY_VALS)

      model.delete(k)
      hashtable.remove(k)

      assert_invariants KEY_VALS, model, hashtable
    end
  end

  def test_remove_unused_key
    model = make_model(KEY_VALS)
    hashtable = make_hashtable(KEY_VALS)

    model.delete(UNUSED_KEY_VAL[0])
    hashtable.remove(UNUSED_KEY_VAL[0])

    assert_invariants (KEY_VALS + [UNUSED_KEY_VAL]), model, hashtable
  end

end
