def improve(update, close_enough, guess = 1):
    while not close_enough(guess):
        guess = update(guess)
    return guess

def approx_eq(x, y, tolerance=1e-15):
    return abs(x - y) < tolerance

def newton_update(f, df):
    def update(x):
        return x - f(x) / df(x)
    return update

def find_zero(f, df):
    def aprox(x):
        return approx_eq(f(x), 0)
    return improve(newton_update(f, df), aprox)

def sqrt_newton(a):
    """
    >>> sqrt_newton(625)
    25.0
    >>> sqrt_newton(0)
    0.0
    """
    if a == 0:
        return 0.0
    def f(x):
        return x * x - a
    def df(x):
        return 2 * x
    return find_zero(f, df)
