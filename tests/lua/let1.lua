assert(not mk_let("a", Type, Var(0), Var(0)):closed())
local env = bare_environment()
local A   = Const("A")
env = add_decl(env, mk_var_decl("A", Type))
env = add_decl(env, mk_var_decl("g", mk_arrow(A, mk_arrow(A, A))))
env = add_decl(env, mk_var_decl("f", mk_arrow(A, Bool)))
env = add_decl(env, mk_var_decl("a", A))
local a  = Const("a")
local b  = Const("b")
local x  = Const("x")
local y  = Const("y")
local g  = Const("g")
local f  = Const("f")
local tc = type_checker(env)
print(Let(x, A, a, f(x)))
print(Let(x, A, a, y, A, f(f(x)), f(x)))
assert(Let(x, A, a, y, A, f(f(x)), f(x)) == Let({{x, A, a}, {y, A, f(f(x))}}, f(x)))
print(Let({{x, A, a}, {y, A, g(g(x), x, a)}}, f(y)))
local t  = Let({{x, A, a}, {y, A, g(g(x), x, a)}}, f(y))
assert(t:let_name()  == name("x"))
assert(t:let_type()  == A)
assert(t:let_value() == a)
assert(t:let_body():is_let())
print(tc:check(Let({{x, A, a}, {y, A, g(g(x, a), x)}}, f(y))))

