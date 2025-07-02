![image](https://github.com/user-attachments/assets/1b9a28b6-9609-4d3d-8187-f75b7259f83e)Kiến thức React Frontend cho Web Application

1. Kiến thức nền tảng (Prerequisites)

*HTML/CSS/JavaScript
- **HTML5**: Semantic HTML, Forms, Accessibility
- **CSS3**: Flexbox, Grid, Responsive Design, Animations
- **JavaScript ES6+**: 
  - Arrow functions, Destructuring, Spread/Rest operators
  - Promises, Async/Await
  - Modules (import/export)
  - Array methods (map, filter, reduce, forEach)
  - Template literals

*Modern JavaScript Concepts
- **Closures và Scope**
- **Event Loop và Asynchronous Programming**
- **DOM Manipulation**
- **Fetch API và HTTP Methods**

2. React Core Concepts
2.1 Components
```jsx
// Functional Component
const MyComponent = () => {
  return <div>Hello World</div>;
};

// Class Component (ít dùng)
class MyComponent extends React.Component {
  render() {
    return <div>Hello World</div>;
  }
}
```

2.2 JSX (JavaScript XML)
- Syntax extension cho JavaScript
- Embedding expressions: `{variable}`
- Conditional rendering: `{condition && <Component />}`
- Lists: `{items.map(item => <Item key={item.id} />)}`

2.3 Props
```jsx
// Parent Component
<ChildComponent name="John" age={25} />

// Child Component
const ChildComponent = ({ name, age }) => {
  return <div>{name} is {age} years old</div>;
};
```

2.4 State Management
```jsx
import { useState } from 'react';

const Counter = () => {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
};
```

3. React Hooks

3.1 useState
```jsx
const [state, setState] = useState(initialValue);
```

3.2 useEffect
```jsx
useEffect(() => {
  // Side effect
  return () => {
    // Cleanup
  };
}, [dependencies]);
```

3.3 useContext
```jsx
const ThemeContext = createContext();

// Provider
<ThemeContext.Provider value={theme}>
  <App />
</ThemeContext.Provider>

// Consumer
const theme = useContext(ThemeContext);
```

3.4 useReducer
```jsx
const [state, dispatch] = useReducer(reducer, initialState);
```

3.5 Custom Hooks
```jsx
const useLocalStorage = (key, initialValue) => {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      return initialValue;
    }
  });

  const setValue = (value) => {
    try {
      setStoredValue(value);
      window.localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
      console.log(error);
    }
  };

  return [storedValue, setValue];
};
```

4. Event Handling

```jsx
const handleClick = (e) => {
  e.preventDefault();
  // Handle event
};

const handleSubmit = (e) => {
  e.preventDefault();
  // Handle form submission
};

return (
  <form onSubmit={handleSubmit}>
    <button onClick={handleClick}>Click me</button>
  </form>
);
```

5. Forms và Validation
5.1 Controlled Components
```jsx
const [formData, setFormData] = useState({
  name: '',
  email: ''
});

const handleChange = (e) => {
  setFormData({
    ...formData,
    [e.target.name]: e.target.value
  });
};

return (
  <form>
    <input 
      name="name"
      value={formData.name}
      onChange={handleChange}
    />
  </form>
);
```

5.2 Form Validation
```jsx
const [errors, setErrors] = useState({});

const validateForm = () => {
  const newErrors = {};
  
  if (!formData.name) {
    newErrors.name = 'Name is required';
  }
  
  if (!formData.email) {
    newErrors.email = 'Email is required';
  } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
    newErrors.email = 'Email is invalid';
  }
  
  setErrors(newErrors);
  return Object.keys(newErrors).length === 0;
};
```

6. Routing (React Router)

6.1 Setup
```jsx
import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/products/:id" element={<Product />} />
      </Routes>
    </BrowserRouter>
  );
}
```

6.2 Navigation
```jsx
import { Link, useNavigate, useParams } from 'react-router-dom';

// Link component
<Link to="/about">About</Link>

// Programmatic navigation
const navigate = useNavigate();
const goToHome = () => navigate('/');

// Get URL parameters
const { id } = useParams();
```

6.3 Protected Routes
```jsx
const ProtectedRoute = ({ children }) => {
  const isAuthenticated = useAuth();
  
  return isAuthenticated ? children : <Navigate to="/login" />;
};
```

7. State Management

7.1 Context API
```jsx
// Create Context
const AppContext = createContext();

// Provider
export const AppProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  
  const value = {
    user,
    setUser,
    login: (userData) => setUser(userData),
    logout: () => setUser(null)
  };
  
  return (
    <AppContext.Provider value={value}>
      {children}
    </AppContext.Provider>
  );
};

// Hook to use context
export const useApp = () => useContext(AppContext);
```

7.2 Redux Toolkit (cho ứng dụng lớn)
```jsx
// Store
import { configureStore } from '@reduxjs/toolkit';
import authSlice from './slices/authSlice';

export const store = configureStore({
  reducer: {
    auth: authSlice,
  },
});

// Slice
import { createSlice } from '@reduxjs/toolkit';

const authSlice = createSlice({
  name: 'auth',
  initialState: {
    user: null,
    isLoading: false,
  },
  reducers: {
    loginStart: (state) => {
      state.isLoading = true;
    },
    loginSuccess: (state, action) => {
      state.user = action.payload;
      state.isLoading = false;
    },
  },
});
```

8. API Integration

8.1 Fetch API
```jsx
const [data, setData] = useState([]);
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);

useEffect(() => {
  const fetchData = async () => {
    try {
      setLoading(true);
      const response = await fetch('/api/data');
      
      if (!response.ok) {
        throw new Error('Failed to fetch');
      }
      
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };
  
  fetchData();
}, []);
```

8.2 Custom API Hook
```jsx
const useApi = (url) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        const result = await response.json();
        setData(result);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [url]);

  return { data, loading, error };
};
```

8.3 Axios (Alternative)
```jsx
import axios from 'axios';

const api = axios.create({
  baseURL: 'https://api.example.com',
  headers: {
    'Content-Type': 'application/json',
  },
});

// Interceptors
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});
```

9. Styling

9.1 CSS Modules
```jsx
import styles from './Component.module.css';

const Component = () => {
  return <div className={styles.container}>Content</div>;
};
```

9.2 Styled Components
```jsx
import styled from 'styled-components';

const Button = styled.button`
  background: ${props => props.primary ? 'blue' : 'white'};
  color: ${props => props.primary ? 'white' : 'blue'};
  padding: 10px 20px;
  border: 2px solid blue;
  border-radius: 4px;
`;
```

9.3 Tailwind CSS
```jsx
const Button = ({ children, primary }) => {
  return (
    <button className={`px-4 py-2 rounded ${primary ? 'bg-blue-500 text-white' : 'bg-white text-blue-500'}`}>
      {children}
    </button>
  );
};
```

10. Performance Optimization

10.1 React.memo
```jsx
const ExpensiveComponent = React.memo(({ data }) => {
  return <div>{/* Complex rendering */}</div>;
});
```

10.2 useMemo
```jsx
const expensiveValue = useMemo(() => {
  return expensiveCalculation(data);
}, [data]);
```

10.3 useCallback
```jsx
const memoizedCallback = useCallback(() => {
  doSomething(a, b);
}, [a, b]);
```

10.4 Lazy Loading
```jsx
const LazyComponent = React.lazy(() => import('./LazyComponent'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <LazyComponent />
    </Suspense>
  );
}
```

11. Testing

11.1 React Testing Library
```jsx
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom';

test('renders button and handles click', () => {
  render(<Button>Click me</Button>);
  
  const button = screen.getByRole('button', { name: /click me/i });
  expect(button).toBeInTheDocument();
  
  fireEvent.click(button);
  // Assert expected behavior
});
```

11.2 Jest
```jsx
describe('utility functions', () => {
  test('should format currency correctly', () => {
    expect(formatCurrency(1000)).toBe('$1,000.00');
  });
});
```

12. Error Handling

12.1 Error Boundaries
```jsx
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.log('Error caught:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }

    return this.props.children;
  }
}
```

12.2 Try-Catch với Async/Await
```jsx
const handleSubmit = async () => {
  try {
    setLoading(true);
    await api.post('/submit', data);
    setSuccess(true);
  } catch (error) {
    setError(error.message);
  } finally {
    setLoading(false);
  }
};
```

13. Best Practices

13.1 Component Structure
- Một component một file
- Tên component PascalCase
- Tên file trùng với tên component
- Export default ở cuối file

13.2 Folder Structure
```
src/
├── components/
│   ├── common/
│   ├── layout/
│   └── ui/
├── pages/
├── hooks/
├── context/
├── services/
├── utils/
└── styles/
```

13.3 Code Organization
- Separate concerns (logic, UI, data)
- Use custom hooks for reusable logic
- Keep components small and focused
- Use TypeScript for type safety

13.4 Naming Conventions
- Components: PascalCase
- Functions: camelCase
- Constants: UPPER_SNAKE_CASE
- Files: PascalCase cho components, camelCase cho utilities

14. Build Tools và Development

14.1 Create React App
```bash
npx create-react-app my-app
cd my-app
npm start
```

14.2 Vite (Faster alternative)
```bash
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

14.3 Package Management
- **npm**: Node Package Manager
- **yarn**: Alternative package manager
- **pnpm**: Fast, disk space efficient

14.4 Environment Variables
```jsx
// .env file
REACT_APP_API_URL=https://api.example.com

// Usage
const apiUrl = process.env.REACT_APP_API_URL;
```

15. Deployment

15.1 Build Process
```bash
npm run build
```
15.2 Deployment Platforms
- **Netlify**: Easy static site deployment
- **Vercel**: Optimized for React apps
- **GitHub Pages**: Free hosting for static sites
- **AWS S3**: Scalable cloud storage
- **Heroku**: Platform as a service

16. Security

16.1 XSS Prevention
- Sanitize user inputs
- Use JSX (automatically escapes)
- Validate on both client and server

16.2 Authentication
```jsx
// JWT Token handling
const token = localStorage.getItem('token');

// Secure HTTP-only cookies (preferred)
const api = axios.create({
  withCredentials: true
});
```

16.3 HTTPS
- Always use HTTPS in production
- Secure sensitive data transmission

17. Advanced Topics

17.1 Server-Side Rendering (SSR)
- **Next.js**: React framework with SSR
- **Gatsby**: Static site generator

17.2 Progressive Web Apps (PWA)
- Service Workers
- Web App Manifest
- Offline functionality

17.3 Micro-frontends
- Module Federation
- Single-spa
- Independent deployments

18. Tools và Libraries hay dùng

18.1 UI Libraries
- **Material-UI (MUI)**: Google Material Design
- **Ant Design**: Enterprise-class UI design
- **Chakra UI**: Modular and accessible
- **React Bootstrap**: Bootstrap components

18.2 Form Libraries
- **Formik**: Build forms without tears
- **React Hook Form**: Performant, flexible forms
- **Yup**: Schema validation

18.3 Animation Libraries
- **Framer Motion**: Production-ready motion library
- **React Spring**: Spring-physics animations
- **Lottie React**: Render After Effects animations

18.4 Date/Time
- **date-fns**: Modern JavaScript date utility
- **moment.js**: Parse, validate, manipulate dates

18.5 Charts
- **Chart.js**: Simple yet flexible charting
- **Recharts**: Redefined chart library
- **D3.js**: Data-driven documents

19. Learning Path

Bắt đầu (Beginner)
1. HTML, CSS, JavaScript cơ bản
2. React cơ bản (Components, Props, State)
3. JSX và Event Handling
4. Hooks (useState, useEffect)

Trung cấp (Intermediate)
1. React Router
2. Context API
3. Custom Hooks
4. API Integration
5. Form Handling

 Nâng cao (Advanced)
1. Performance Optimization
2. Testing
3. Advanced Hooks
4. State Management (Redux)
5. TypeScript

Chuyên sâu (Expert)
1. SSR/SSG
2. Micro-frontends
3. Advanced Patterns
4. Build Tools
5. Deployment Strategies

20.Tài liệu tham khảo

Official Documentation
- [React Documentation](https://react.dev/)
- [React Router](https://reactrouter.com/)
- [Redux Toolkit](https://redux-toolkit.js.org/)

Learning Resources
- freeCodeCamp
- Codecademy
- Udemy
- YouTube channels (Traversy Media, Academind)

Practice Projects
1. Todo App
2. Weather App
3. E-commerce Site
4. Social Media Dashboard
5. Blog Platform
   
Ứng dụng thực tế của kiến thức frontend trong đồ án
| Tính năng                                      | Kiến thức React áp dụng                                            |
| ---------------------------------------------- | ------------------------------------------------------------------ |
| Đăng nhập/Đăng ký                              | `useState`, `useEffect`, `fetch` hoặc `axios`, validation, routing |
| Giao diện task & user                          | `Props`, `Lists`, `Conditional Rendering`, `React.memo`            |
| Chỉnh sửa task                                 | `Forms`, `Controlled Components`, validation                       |
| Quản lý người dùng (Admin)                     | `React Router`, `ProtectedRoute`, phân quyền                       |
| Giao tiếp backend                              | `API Integration`, `Custom Hooks`, `Error Handling                 |
| Quản lý trạng thái user                        | `Context API` hoặc `Redux Toolkit`                                 |
| Responsive UI                                  | `TailwindCSS` hoặc `CSS Modules`, Flexbox, Grid                    |
| Hiển thị biểu đồ (progress hoặc thống kê task) | `Recharts` hoặc `Chart.js`                                         |




