import time
from datetime import timedelta

@python
def printf(data):
    print('{:.15f}'.format(data))

def Leibniz(max_iter : int):
    arr = reversed(range(max_iter))
    _sum = 0.0

    for k in arr:
        _sum += ((-1) ** (k % 2) + 0.0) / (2 * k + 1)
    pi = _sum * 4

    return pi

if __name__ == '__main__':
    max_iter = 1_000_000_000

    start_time = time.time()
    # estimate pi
    hat_pi = Leibniz(max_iter)
    elapsed_time = time.time() - start_time
    output = str(timedelta(seconds=elapsed_time))

    printf(hat_pi)
    print(output)
