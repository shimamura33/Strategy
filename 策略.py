import numpy as np
import operator
from datetime import datetime

start = datetime(2015, 1, 1)
end   = datetime(2018, 12, 31)
benchmark = 'HS300'
universe  = set_universe('HS300')
freq='d'
capital_base = 100000
refresh_rate = 5

def initialize(account):
    account.stocks_num = 10

def handle_data(account):
    hist_prices = account.get_attribute_history('closePrice', 5)

    yangtuos = list(YangTuo(set(account.universe)-set(account.security_position.keys()), account.stocks_num))
    cash = account.cash

    if account.stocks_num == 1:        
        hist_returns = {} 
        for stock in account.valid_secpos:
            hist_returns[stock] = hist_prices[stock][-1]/hist_prices[stock][0]

        sorted_returns = sorted(hist_returns.items(), key=operator.itemgetter(1))
        sell_stock = sorted_returns[0][0]

        cash = account.cash + hist_prices[sell_stock][-1]*account.valid_secpos.get(sell_stock)
        account.order_to(sell_stock, 0)
    else:
        account.stocks_num = 1
    
    for stock in yangtuos:
        account.order(stock, cash/len(yangtuos)/hist_prices[stock][-1])

        
class YangTuo:
    def __init__(self, caoyuan=[], count=10):
        self.count = count
        self.i = 0
        self.caoyuan = list(caoyuan)
        
    def __iter__(self):
        return self

    def next(self):
        if self.i < self.count:
            self.i += 1
            return self.caoyuan.pop(np.random.randint(len(self.caoyuan)))
        else:
            raise StopIteration()        
