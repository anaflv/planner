export class Customer {
    id: number;
    name: string;
    address: Address;
  }
  
  export class Address {
    street: string;
    city: string;
    state: string;
    region: string;
  }

  export class UserData {

    bi: string;
    postBi: number;
    classes: string;

  }

  export interface Course {
    
    codigo: string;
  }

  export interface UfabcClass {
    name: string;
  }

  export interface ClassList {
    especificas: UfabcClass[];
    obrigatorias: UfabcClass[];
    livres: UfabcClass[];
  }
