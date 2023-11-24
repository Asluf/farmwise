import { useState, createContext, useContext } from 'react';

const ToggleStateContext = createContext();

export const ToggleStateProvider = ({ children }) => {
    const [isToggled, setIsToggled] = useState(false);

    const toggle = () => {
        setIsToggled((prev) => !prev);
    };

    return (
        <ToggleStateContext.Provider value={{ isToggled, toggle }}>
            {children}
        </ToggleStateContext.Provider>
    );
};

export const useToggleState = () => {
    const context = useContext(ToggleStateContext);
    if (!context) {
        throw new Error('useToggleState must be used within a ToggleStateProvider');
    }
    return context;
};
