import numpy as np


class LinearRegression:
    def __init__(self, learning_rate=0.05) -> None:
        self.theta = None
        self.learning_rate = learning_rate

    def fit(self, X, y):
        X = np.concatenate((X, np.ones((len(X), 1))), axis=1)
        self.theta = np.zeros(X.shape[1])
        for i in range(1500):
            y_hat = X.dot(self.theta)
            self.theta = self.theta - self.learning_rate * self.gradient(X, y_hat, y)

            if i % 100 == 0:
                print(i,':', self.theta)
    
    def gradient(self, X, y_hat, y):
        return (y_hat - y).dot(X) / len(y)
    
    def predict(self, X):
        X = np.concatenate((X, np.ones((len(X), 1))), axis=1)
        return X.dot(self.theta)

def main():
    X = np.array([[1, 1], [1, 2], [2, 2], [2, 3]])
    y = np.dot(X, np.array([1, 2])) + 3
    
    reg = LinearRegression()
    reg.fit(X,y)
    print(reg.theta)
    print(y)
    print(reg.predict(X))
    
main()