//
//  Movies.swift
//  MovieDB
//
//  Created by Assel Artykbay on 31.10.2024.
//

import Foundation

struct Movies: Codable {
    let page: Int
    let results: [Movie]
    let total_pages, total_results: Int
}
