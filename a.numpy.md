# 1) np.array()
>import numpy as np  
>a = np.array([2,3,4])  
>a  


# 1) np.array()
>import numpy as np  
a = np.array([2,3,4])  
a  
array([2, 3, 4])  


# 2) np.zeros()  
>np.zeros((3,4))  
array([[0., 0., 0., 0.],  
       [0., 0., 0., 0.],  
       [0., 0., 0., 0.]])  


# 3) np.ones()
>np.ones((2,3,4))  
array([[[1., 1., 1., 1.],  
        [1., 1., 1., 1.],  
        [1., 1., 1., 1.]],  

       [[1., 1., 1., 1.],  
        [1., 1., 1., 1.],  
        [1., 1., 1., 1.]]])  
  

# 4) np.full()
>np.full((2, 2), [1, 2])  
array([[1, 2],  
       [1, 2]])  


# 5) np.ravel()
>a = np.array([[1,2,3],[4,5,6]])  
np.ravel(a)  
array([1, 2, 3, 4, 5, 6])  


# 6) np.dot()
>np.dot(3,4)  
12  


# 7) np.concatenate()
>a = np.array([[1, 2], [3, 4]])  
b = np.array([[5, 6]])   
np.concatenate((a, b), axis=0)  
array([[1, 2],  
       [3, 4],  
       [5, 6]])  


# 8) np.vstack()
>a = np.array([1, 2, 3])  
b = np.array([4, 5, 6])  
np.vstack((a,b))  
array([[1, 2, 3],  
       [4, 5, 6]])  


# 9) np.where()
>a = np.arange(10)  
np.where(a < 5, a, 10*a)  
array([ 0,  1,  2,  3,  4, 50, 60, 70, 80, 90])  


# 10) np.std()
>a = np.array([[1, 2], [3, 4]])  
np.std(a)  
1.118033988749895  


# 11) np.max
>a = np.arange(4).reshape((2,2))  
np.max(a)  
3  


# 12) np.argmax()
>a = np.arange(6).reshape(2,3) + 10  
np.argmax(a)  
5  


# 13) np.eye()
>np.eye(2, dtype=int)  
array([[1, 0],  
       [0, 1]])  


# 14) np.arange()
>np.arange(0, 5, 0.5, dtype=int)  
array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])  


# 15) np.linspace()
>np.linspace(2.0, 3.0, num=5)  
array([2.  , 2.25, 2.5 , 2.75, 3.  ])  


# 16) np.reshape()
>a = np.arange(6).reshape((3, 2))  
a  
array([[0, 1],  
       [2, 3],  
       [4, 5]])  


# 17) np.transpose()
>a = np.array([[1, 2], [3, 4]])  
a  
np.transpose(a)  
array([[1, 3],  
       [2, 4]])  


# 18) np.cross()  
>a = [1, 2, 3]  
b = [4, 5, 6]  
np.cross(x, y)  
                      

# 19) np.split()
>a = np.arange(9.0)  
np.split(a, 3)  


# 20) np.hstack()
>a = np.array((1,2,3))  
b = np.array((4,5,6))  
np.hstack((a,b))  


# 21) np.mean()
>a = np.array([[1, 2], [3, 4]])  
np.mean(a)  


# 22) np.min()
>a = np.arange(4).reshape((2,2))  
np.min(a)  


# 23) np.argmin()
>a = np.arange(6).reshape(2,3) + 10  
np.argmin(a)  


# 24) np.unique()
>np.unique([1, 1, 2, 2, 3, 3])  