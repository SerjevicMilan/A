def improve(update, close_enough, guess = 1):
    while not close_enough(guess):
        guess = update(guess)
        print(guess)
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

def power(x, n):
    res, k = 1, 0
    while k < n:
        res, k = res * x, k + 1
    return res

def n_root_newton(a, n):
    """
    >>> n_root_newton(625, 3)
    3.0
    """
    if a == 0:
        return 0.0
    def f(x):
        return power(x, n) - a
    def df(x):
        return n * power(x, n-1)
    return find_zero(f, df)
