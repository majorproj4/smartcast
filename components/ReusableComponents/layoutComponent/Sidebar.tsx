"use client"
import { usePathname } from 'next/navigation'
import React from 'react'

type Props = {}

const Sidebar = (props: Props) => {
    const pathname = usePathname()
  return (
    <div >Sidebar</div>
  )
}

export default Sidebar