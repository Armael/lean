local env = bare_environment()
local g   = name_generator("tst")
local tc  = type_checker(env, g)
assert(is_type_checker(tc))
local a   = Const("a")
local t   = Fun(a, Bool, a)
local b   = Const("b")
print(t(b))
assert(tc:whnf(t(b)) == b)
local cs  = {}
local tc2 = type_checker(env, g, constraint_handler(function (c) print(c); cs[#cs+1] = c end))
assert(tc:check(Bool) == mk_sort(mk_level_one()))
print(tc:infer(t))
local m   = mk_metavar("m1", mk_metavar("m2", mk_sort(mk_meta_univ("u"))))
print(tc:infer(m))
local t2  = Fun(a, Bool, m(a))
print(t2)
print(tc2:check(t))
print(tc2:check(t2))
assert(#cs == 2)
