import { onAuthenticateUser } from '@/src/actions/auth'
import React from 'react'
import { redirect } from 'next/navigation'
import Sidebar from '../../components/ReusableComponents/layoutComponent/Sidebar'

type Props = {
    children:React.ReactNode
}

const layout = async({children}: Props) => {
    const userExist = await onAuthenticateUser()

    if(!userExist.user){
        redirect('/sign-in')
    }
  return (
    <div className='flex w-full min-h-screen'>
        {/* {sidebar} */}
        <Sidebar/>
        {/* navbar */}
        {/* header */}
        {/* children */}
    </div>
  )
}

export default layout