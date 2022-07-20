// ...

const ClientRawData = () => {

    const [searchParams, setSearchParams] = useSearchParams();

    console.log(JSON.stringify(searchParams.get(`task`)));

    const data = [searchParams.get(`task`)];

    return null;
};